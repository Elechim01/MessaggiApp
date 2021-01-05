//
//  Dati.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage


class Gestione: ObservableObject{
//    prova senza databse
    // creazione proprietario
   
    @Published var Prorpietario : Utente = Utente(nome: "Michele", cognome: "Manniello", idf: "4", nickname: "Miky", numeroTelefono: "40", image: "Tulipani")
    
    @Published var utenti : [Utente] = []
//        [Utente(nome: "Pippo", cognome: "baudo", idf: "", nickname: "Poppi", numeroTelefono: "30", image: #imageLiteral(resourceName: "Tulipani")),Utente(nome: "Michele", cognome: "Manniello", idf: "", nickname: "Miky", numeroTelefono: "40", image: #imageLiteral(resourceName: "Tulipani")),Utente(nome: "Nicola", cognome: "Manniello", nickname: "Nick", numeroTelefono: "20", image: #imageLiteral(resourceName: "Busta"))]
//    creazione conversazione
    @Published var elencoChat : [Chat] = []
//        [Chat(image: "Tulipani", messaggi: [Messaggi(testo: "Ciao", data: Date(),telefono: "30")],telefono: "30")]
    @Published var messaggi : [Messaggi] = []

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
//    Funzione che serve per trovare gli utente in base al numero di telefono
    func trovaUtenti(telefono: String) -> Utente?{
        if(Prorpietario.numeroTelefono == telefono){
            return Prorpietario
        }else{
        for ut in utenti {
            if(ut.numeroTelefono == telefono){
                print(ut.nome,ut.numeroTelefono)
                return ut
            }
        }
        return Utente(nome: "", cognome: "", idf: "", nickname: "", numeroTelefono: "", image: "Tulipani")
        }
    }
    func ControlloAggiuntaChat(chat : Chat){
        var trovato = false
        for chati in elencoChat {
            if(chat.telefono == chati.telefono){
                trovato = true
            }
        }
        if(trovato == false){
            elencoChat.append(chat)
        }
        
    }
    
    func RicercaElementi(cerca : String) -> [Chat] {
        var chattrovate :[Chat] = []
        if cerca == "" {
            return elencoChat
        }else{
//            trovare gli utenti e confrontare il nome
            for chat in elencoChat {
                if ControllaCaratteri(stringaDacontrollare: trovaUtenti(telefono: chat.telefono)!.nickname ,cerca:cerca) == true{
                    chattrovate.append(chat)
                }
            }
            
        }
        return chattrovate
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
        db.collection("Utente").getDocuments(completion: { [self](snap,err) in
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
                    let telefono = msg["telefono"] as? String ?? ""
                    DispatchQueue.main.async {
//                        let c = self.LeggiMessaggio(idf: id)
//                        print(" ☠️ Ricezione messaggio\(c)")
                        self.elencoChat.append(Chat(image: image, messaggi: [], telefono:telefono, idf: id))
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
    var telefono : String // indica il destinatario della chat.
    var messaggi : [Messaggi]
    init(image : String,messaggi : [Messaggi], telefono: String,idf:String) {
        self.imge = image
        self.messaggi = messaggi
        self.telefono = telefono
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
