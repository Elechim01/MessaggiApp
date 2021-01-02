//
//  Dati.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import Foundation
import UIKit


class Utente: Identifiable {
    var id = UUID().uuidString
    var nome : String
    var image : UIImage
    init(nome: String, image : UIImage) {
        self.nome = nome
        self.image = image
    }
}
class Chat: Identifiable {
    var id = UUID().uuidString
    var testo : String
    var data : Date
    var utente : Utente
    init(testo : String, data : Date, utente : Utente) {
        self.testo = testo
        self.data = data
        self.utente = utente
    }
    
}
