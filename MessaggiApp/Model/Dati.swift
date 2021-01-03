//
//  Dati.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import Foundation
import UIKit

class Gestione: NSObject,ObservableObject{
//    prova senza databse
    // creazione proprietario
    @Published var Prorpietario : Utente = Utente(nome: "Michele", cognome: "Manniello", nickname: "Miky", numeroTelefono: "40", image: #imageLiteral(resourceName: "Tulipani"))
    
   @Published var utenti : [Utente] = [Utente(nome: "Pippo", cognome: "baudo", nickname: "Poppi", numeroTelefono: "30", image: #imageLiteral(resourceName: "Tulipani")),Utente(nome: "Michele", cognome: "Manniello", nickname: "Miky", numeroTelefono: "40", image: #imageLiteral(resourceName: "Tulipani"))]
//    creazione conversazione
    @Published var elencoChat : [Chat] =
        [Chat(image: "Tulipani", messaggi: [Messaggi(testo: "Ciao", data: Date(),telefono: "30")],telefono: "30")]
    
    func AddMessage(txt: String,chat: Chat,utente : Utente) {
        chat.messaggi.append(Messaggi(testo: txt, data: Date(),telefono: utente.numeroTelefono))
    }
//    Funzione che serve per trovare gli utente in base al numero di telefono
    func trovaUtenti(telefono: String) -> Utente?{
        print(telefono)
        for ut in utenti {
            if(ut.numeroTelefono == telefono){
                print(ut.nome,ut.numeroTelefono)
                return ut
            }
        }
        return Utente(nome: "", cognome: "", nickname: "", numeroTelefono: "", image: #imageLiteral(resourceName: "Busta"))
    }
    
    
    
}
//Utente ha nome,cognome,nickname,numeroTelefono,image -> raccoglie tutti gli utenti
class Utente: Identifiable {
    var id = UUID().uuidString
    var nome : String
    var cognome: String
    var nickname : String
    var numeroTelefono: String
    var image : UIImage
    init(nome: String,cognome : String,nickname: String, numeroTelefono : String,image : UIImage) {
        self.nome = nome
        self.image = image
        self.cognome = cognome
        self.nickname = nickname
        self.numeroTelefono = numeroTelefono
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
