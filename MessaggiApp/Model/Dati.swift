//
//  Dati.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//
//

import Foundation
import SwiftUI
import UIKit
import FirebaseFirestore
import FirebaseStorage
import Firebase


class Gestione: ObservableObject{
//    prova senza databse
    // creazione proprietario
    @Published var Prorpietario : Utente = Utente(nome: "Michele", cognome: "Manniello", idf: "4", nickname: "Miky", numeroTelefono: "40", image: "Tulipani")
    
    @Published var utenti : [Utente] = []
    @Published var utenteDaAggiungere : Utente = Utente(nome: "", cognome: "", idf: "", nickname: "", numeroTelefono: "", image: "")
//        [Utente(nome: "Pippo", cognome: "baudo", idf: "", nickname: "Poppi", numeroTelefono: "30", image: #imageLiteral(resourceName: "Tulipani")),Utente(nome: "Michele", cognome: "Manniello", idf: "", nickname: "Miky", numeroTelefono: "40", image: #imageLiteral(resourceName: "Tulipani")),Utente(nome: "Nicola", cognome: "Manniello", nickname: "Nick", numeroTelefono: "20", image: #imageLiteral(resourceName: "Busta"))]
//    creazione conversazione
    @Published var elencoChat : [Chat] = []
//        [Chat(image: "Tulipani", messaggi: [Messaggi(testo: "Ciao", data: Date(),telefono: "30")],telefono: "30")]
    @Published var messaggi : [Messaggi] = []
    @Published var numeroTelefono  = ""
    
    
//Valori di ritorno di firebase
//    Valore che controlla il login, la registazione, e l'accesso
//    inizlamente settato a 0
    @AppStorage("StatoAccesso") var valoreAggiunto:Int = 0
    @AppStorage("NumeroTelefono") var numeroTelefonoPermanente: String = "40"
    //"40" //"+393381356237"
    
//    Imeplemntare errori
    @Published var numeroNonValido = false
    
//    Autenticazione
    @Published var CODE = ""
    @Published var code = ""
    @Published var alert : Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading : Bool = false
    
//    Gestione Immagine
    @Published var acquisizioneImage : UIImage?
    @Published var selezionaAcquisizioneImge : Bool = false
    @Published var url = ""
    
    init() {
     Lettura()
    LeggiChat()
    LeggiMessaggio()
   }
    
    func FiltroMessaggi(altroUtente: Utente) -> [Messaggi] {
        var mess : [Messaggi] = []
        for messagge in messaggi {
            if((messagge.destinatario == Prorpietario.numeroTelefono && messagge.mittente == altroUtente.numeroTelefono)||(messagge.destinatario == altroUtente.numeroTelefono && messagge.mittente == Prorpietario.numeroTelefono)){
                mess.append(messagge)
            }
        }
        return mess
    }
  
//    Funzione che serve per trovare gli utente in base al numero di telefono
    func trovaDestinatario (ut: String,ut1:String) -> Utente?{
//        Problema che la chat ha 2 utenti che inviano messaggi
        if (ut == Prorpietario.numeroTelefono){
            for utt in utenti {
                if(ut1 == utt.numeroTelefono){
                    return utt
                }
            }
        }else{
//       significa che  ut1 == Prorpietario.numeroTelefono
            for utt in utenti {
                if(utt.numeroTelefono == ut){
                    return utt
                }
            }
        
        }
        return Utente(nome: "", cognome: "", idf: "", nickname: "", numeroTelefono: "", image: "Tulipani")
    }
    
    func ControlloAggiuntaChat(chat : Chat){
        var trovato = false
        for chati in elencoChat {
            if((chat.ut == chati.ut) || (chat.ut == chat.ut1) || (chat.ut1 == chat.ut1)){
                trovato = true
            }
        }
        if(trovato == false){
//            Implementare l'aggiunta chat
            elencoChat.append(chat)
            self.AddChat(chat: chat)
        }
        
    }
    
    func RicercaElementi(cerca : String) -> [Chat] {
//        1. trovare tutte le chat che contengono il proprietario.
//        2. Applicare i filtri
        var chattrovate :[Chat] = []
        if cerca == "" {
//            Controllare
            return TrovaChat()
        }else{
//            trovare gli utenti e confrontare il nome
            for chat in TrovaChat() {
                if ControllaCaratteri(stringaDacontrollare: trovaDestinatario(ut: chat.ut, ut1: chat.ut1)!.nickname,cerca:cerca) == true{
                    chattrovate.append(chat)
                }
            }
        }
        return chattrovate
    }
//trovare tutte le chat che contengono il proprietario.
    func TrovaChat() -> [Chat] {
        var chat: [Chat] = []
        for chati in self.elencoChat {
            if((chati.ut == Prorpietario.numeroTelefono) || (chati.ut1 == Prorpietario.numeroTelefono)){
                chat.append(chati)
            }
        }
       return chat
    }
    
//    Funzione che trova gli utenti per gestire i messaggi
    func trovaUtenti(telefono : String) -> Utente {
        if(telefono == Prorpietario.numeroTelefono){
            return Prorpietario
        }else{
            for utente in utenti{
                if(utente.numeroTelefono == telefono){
                    return utente
                }
            }
        }
return Utente(nome: "", cognome: "", idf: "", nickname: "", numeroTelefono: "", image:  "")
    }
    
//    Funzione che controlla carattere per carattere
    
    func ControllaCaratteri(stringaDacontrollare : String, cerca: String) -> Bool {
        let controllare  = Array(stringaDacontrollare)
        let cercaChar = Array(cerca)
//        ciclo che controlla la stringa
        for control in controllare {
//            ciclo che controlla il cerca
            for cer in cercaChar {
                if control == cer {
                    return true
                }
            }
            
        }
        return false
    }

// FIREBASE
    
    func Lettura(){
        let db = Firestore.firestore()
        db.collection("Utente").addSnapshotListener({ [self](snap,err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }else{
                guard let data = snap else{return}
                data.documentChanges.forEach{doc in
                    if doc.type == .added{
                        let dati = doc.document.data()
//                        Ottengo l'id del documento
                        let idf = doc.document.documentID
                        let nome = dati["Nome"] as? String ?? ""
                        let cognome = dati["cognome"] as? String ?? ""
                        let nickname = dati["nickname"] as? String ?? ""
                        let numerotelfono = dati["numeroTelefono"] as? String ?? ""
                        let urlimage = dati["image"] as? String ?? ""
                        if(numeroTelefonoPermanente == numerotelfono){
                            self.Prorpietario = Utente(nome: nome, cognome: cognome, idf: idf, nickname: nickname, numeroTelefono: numerotelfono, image: urlimage)
                        }
                        self.utenti.append(Utente(nome: nome, cognome: cognome, idf: idf, nickname: nickname, numeroTelefono: numerotelfono, image: urlimage))
                        
                    }
                }
            }
        })
    }
    
    func LeggiChat(){
        let db = Firestore.firestore()
//        Lettura Messaggi
        db.collection("Chat").addSnapshotListener({ (QuerySnapshot, Error) in
            if Error != nil{
                print(Error!.localizedDescription)
                return
            }
            guard  let data = QuerySnapshot else{return}
            data.documentChanges.forEach { (doc) in
//                Addidng where data is added
                if doc.type == .added{
                    let id = doc.document.documentID
                    let msg =  doc.document.data()
                    let image = msg["image"] as? String ?? ""
                    let utente = msg["utente"] as? String ?? ""
                    let utente1 = msg["utente1"] as? String ?? ""
                    DispatchQueue.main.async {
//                        let c = self.LeggiMessaggio(idf: id)
//                        print(" ☠️ Ricezione messaggio\(c)")
                        self.elencoChat.append(Chat(image: image, messaggi: [], ut: utente,ut1: utente1, idf: id))
                    }
                    
                }
            }
        })
    }
    
    func LeggiMessaggio() {
        let db = Firestore.firestore()
        db.collection("Messaggi").order(by:"data",descending: false).addSnapshotListener(  { (snap, err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            guard let data = snap else{return}
            data.documentChanges.forEach{doc in
                if doc.type == .added{
                    let msg = doc.document.data()
                    let idf = doc.document.documentID
                    let testo = msg["testo"] as? String ?? ""
                    let telefono = msg["telefono"] as? String ?? ""
                    let data = msg["data"] as? Date ?? Date()
                    let destinatario = msg["Destinatario"] as? String ?? ""
                    let mittente = msg["mittente"] as? String ?? ""
                    print("☠️ dati del messaggio testo: \(testo), telefono \(telefono),data\(data)")
//                    DispatchQueue.main.async {
                    self.messaggi.append(Messaggi(testo: testo, idf: idf, data: data, mittente: mittente, destinatario: destinatario))
//                    }

                }
            }
        })
    }
    
    func AggiungiUtente(){
        let db = Firestore.firestore()
        _ = try!db.collection("Utente").addDocument(data: [
            "Nome":self.utenteDaAggiungere.nome,
            "cognome":self.utenteDaAggiungere.cognome,
            "nickname":self.utenteDaAggiungere.nickname,
            "numeroTelefono":self.utenteDaAggiungere.numeroTelefono,
            "image":self.utenteDaAggiungere.image
        ],completion: { (err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
        })
    }
    
    func AddMessage(messag : Messaggi) {
        let db = Firestore.firestore()
//        db.collection("Msgs").addDocument(from: messag,)
        let _ = try! db.collection("Messaggi").addDocument(data: [
            "testo":messag.testo,
            "mittente":messag.mittente,
            "Destinatario":messag.destinatario,
            "data":messag.data],completion: { (Error) in
                if Error != nil{
                    print(Error!.localizedDescription)
                    return
                }
            })
        
//        chat.messaggi.append(Messaggi(testo: txt, data: Date()))
    }
    
//    Controlla che l'utente sia nel databse, se è presente aggunte il numero nel propeitario e trona true, altrimenti torna false
    func controlloUtente() {
//        devo accedere e controllare che il numero sia presente, se c'è aggiugo il proprietario, e ritorno se è stato aggiunto o mento
        let db = Firestore.firestore()
        db.collection("Utente").getDocuments { (quary, err) in
            guard err == nil else{
                print(err!.localizedDescription)
                return
            }
            for document in quary!.documents{
                let data = document.data()
//                Leggo il numero
                let numerout = data["numeroTelefono"] as? String ?? ""
                if(numerout == self.numeroTelefono){
//                    creazione utente
                    let idf = document.documentID
                    let nome = data["Nome"] as? String ?? ""
                    let cognome = data["cognome"] as? String ?? ""
                    let nickname = data["nickname"] as? String ?? ""
                    let image = data["image"] as? String ?? ""
                    self.valoreAggiunto = 1
                    self.numeroTelefonoPermanente = numerout
                    self.Prorpietario = Utente(nome: nome, cognome: cognome, idf: idf, nickname: nickname, numeroTelefono: numerout, image: image)
                }else{
                    self.isLoading.toggle()
                    self.numeroNonValido.toggle()
                }
            }
            
        }
    }
    
    func Autenticazione(){
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        Auth.auth().languageCode = "it"
        self.isLoading.toggle()
        PhoneAuthProvider.provider().verifyPhoneNumber("+39"+self.numeroTelefono, uiDelegate: nil) { (CODE, err) in
            self.isLoading.toggle()
             if err != nil{
//                Implemntare alert
                self.alertMessage = err!.localizedDescription
                self.alert.toggle()
                return
            }
            self.CODE = CODE!
//            Creazione alert
            let alertView = UIAlertController(title: "Verifica", message: "Inserisci il codice", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            let conferma = UIAlertAction(title: "OK", style: .default) { (_) in
                if let otp = alertView.textFields![0].text{
                    let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: otp)
                    self.isLoading.toggle()
                    Auth.auth().signIn(with: credential) { (red, err) in
                        self.isLoading.toggle()
                        if err != nil{
                            self.alertMessage = err!.localizedDescription
                            self.alert.toggle()
                            return
                        }
                    }
//                    Spostarsi nella content view
                    self.valoreAggiunto = 2
                }
            }
            alertView.addTextField(configurationHandler: nil)
            alertView.addAction(cancel)
            alertView.addAction(conferma)
//            Uscita
            UIApplication.shared.windows.first?.rootViewController?.present(alertView, animated: true, completion: nil)
        }
    }
// aggiunta chat
    func AddChat(chat : Chat){
        let db = Firestore.firestore()
        let _ = try! db.collection("Chat").addDocument(data: [
            "utente":chat.ut1,
            "utente1": chat.ut,
            "image" : chat.imge
        ], completion: { (err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
        })
    }
    
    func CaricaImmagine(){
//        acquisizioneImage
        let storage = Storage.storage().reference()
        let ref = storage.child("immagine _ profilo").child(Auth.auth().currentUser!.uid)
        let data = acquisizioneImage!.jpegData(compressionQuality: 0.5)!
        
        self.isLoading.toggle()
        ref.child("img\(acquisizioneImage!)").putData(data, metadata: nil) { (_, err) in
            self.isLoading.toggle()
            if err != nil{
                self.alertMessage = err!.localizedDescription
                self.alert.toggle()
                return
            }
        }
        ref.child("img\(acquisizioneImage)").downloadURL { (URL, _) in
            guard let imageUrl = URL else {return}
            self.url = "\(imageUrl)"
        }
        
    }
    
//    Funzione che aggiunge un utente
    
    
//    func dowloadimage(percorso: String) -> UIImage {
//        print("☠️",percorso)
//        var image : UIImage = UIImage(imageLiteralResourceName: "Busta")
//        let storage = Storage.storage().reference(forURL: percorso)
//        storage.getData(maxSize: (2 * 1024 * 1024)) { (data, err) in
//            if err != nil{
//                print("☠️  \(err!.localizedDescription)")
//                return
//            }
//            print("☠️\(data!)")
//            let myimage = UIImage(data: data!)
//            image = myimage!
//            print("☠️ immagine dowload\(myimage!)")
//        }
//        print("☠️ image \(image)")
//        return image
//    }
}
//Utente ha nome,cognome,nickname,numeroTelefono,image -> raccoglie tutti gli utenti
class Utente: Identifiable {
    var id = UUID().uuidString
    var idf : String
    var nome : String
    var cognome: String
    var nickname : String
    var numeroTelefono: String
    var image : String
    init(nome: String,cognome : String,idf: String,nickname: String, numeroTelefono : String,image : String) {
        self.nome = nome
        self.image = image
        self.cognome = cognome
        self.nickname = nickname
        self.numeroTelefono = numeroTelefono
        self.idf = idf
        
    }
}
//La chat contiene immagine,telfono,[messaggi],-> memorizza tutte le conversazioni e viene mostrata nei messaggi
class Chat:Identifiable{
    var id = UUID().uuidString
    var idf : String
    var imge : String
    var ut : String// utenti
    var ut1 : String // indica l'atro utente
    var messaggi : [Messaggi]
    init(image : String,messaggi : [Messaggi], ut: String,ut1: String,idf:String) {
        self.imge = image
        self.messaggi = messaggi
        self.ut = ut
        self.ut1 = ut1
        self.idf = idf
    }
    
}
//conitne testo,data,telefono -> sono i veri e prori messaggi
//il messaggio deve avere un destinatario e un mittente, cosi da port filtrare il messaggio con la chat
class Messaggi: Identifiable,Equatable {
    static func == (lhs: Messaggi, rhs: Messaggi) -> Bool {
        return lhs.mittente == rhs.mittente
    }
    
    var id = UUID().uuidString
    var testo : String
    var idf : String
    var data : Date
    var destinatario : String
    var mittente: String
    init(testo : String, idf: String,data:Date,mittente: String,destinatario: String) {
        self.testo = testo
        self.data = data
        self.idf = idf
        self.mittente = mittente
        self.destinatario = destinatario
    }
}
