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
   
    @Published var Prorpietario : Utente = Utente(nome: "Michele", cognome: "Manniello", idf: "4", nickname: "Miky", numeroTelefono: "40", image: #imageLiteral(resourceName: "Tulipani"))
    
    @Published var utenti : [Utente] = []
//        [Utente(nome: "Pippo", cognome: "baudo", idf: "", nickname: "Poppi", numeroTelefono: "30", image: #imageLiteral(resourceName: "Tulipani")),Utente(nome: "Michele", cognome: "Manniello", idf: "", nickname: "Miky", numeroTelefono: "40", image: #imageLiteral(resourceName: "Tulipani")),Utente(nome: "Nicola", cognome: "Manniello", nickname: "Nick", numeroTelefono: "20", image: #imageLiteral(resourceName: "Busta"))]
//    creazione conversazione
    @Published var elencoChat : [Chat] =
        [Chat(image: "Tulipani", messaggi: [Messaggi(testo: "Ciao", data: Date(),telefono: "30")],telefono: "30")]

    init() {
     Lettura()
   }
    func AddMessage(txt: String,chat: Chat,utente : Utente) {
        chat.messaggi.append(Messaggi(testo: txt, data: Date(),telefono: utente.numeroTelefono))
    }
//    Funzione che serve per trovare gli utente in base al numero di telefono
    func trovaUtenti(telefono: String) -> Utente?{
        for ut in utenti {
            if(ut.numeroTelefono == telefono){
                print(ut.nome,ut.numeroTelefono)
                return ut
            }
        }
        return Utente(nome: "", cognome: "", idf: "", nickname: "", numeroTelefono: "", image: #imageLiteral(resourceName: "Busta"))
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
//                        let urlimage = dati["image"] as? String ?? ""
                        self.utenti.append(Utente(nome: nome, cognome: cognome, idf: idf, nickname: nickname, numeroTelefono: numerotelfono, image: dowloadimage(percorso: numerotelfono)))
                        
                    }
                }
            }
        })
    }
    func dowloadimage(percorso: String) -> UIImage {
        let storage = Storage.storage().reference()
        storage.child("Tulipán-768x768").downloadURL { (url, err) in
            if err != nil{
                print("☠️",err!.localizedDescription)
                return
            }
            print("☠️URL IMMAGINI \(String(describing: url!))")
        }
        return UIImage(imageLiteralResourceName: "Tulipani")
    }
    
    
    
}
//Utente ha nome,cognome,nickname,numeroTelefono,image -> raccoglie tutti gli utenti
class Utente: Identifiable {
    var id = UUID().uuidString
    var idf : String
    var nome : String
    var cognome: String
    var nickname : String
    var numeroTelefono: String
    var image : UIImage
    init(nome: String,cognome : String,idf: String,nickname: String, numeroTelefono : String,image : UIImage) {
        self.nome = nome
        self.image = image
        self.cognome = cognome
        self.nickname = nickname
        self.numeroTelefono = numeroTelefono
        self.idf = idf
        
    }
}
//La chat contiene immagine,telfono,[messaggi],-> memorizza tutte le conversazioni e viene mostrata nei messaggi
class Chat: Identifiable {
    var id = UUID().uuidString
    var imge : String
    var telefono : String // indica il destinatario della chat.
    var messaggi : [Messaggi]
    init(image : String,messaggi : [Messaggi], telefono: String ) {
        self.imge = image
        self.messaggi = messaggi
        self.telefono = telefono
    }
    
}
//conitne testo,data,telefono -> sono i veri e prori messaggi
class Messaggi: Identifiable {
    var id = UUID().uuidString
    var testo : String
    var data : Date
    var telefono  : String
    init(testo : String, data:Date,telefono: String) {
        self.testo = testo
        self.data = data
        self.telefono = telefono
    }
}
