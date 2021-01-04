//
//  ChatView.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI

struct ChatView: View {
//    scaricamento lista di messaggi dal databse
    @EnvironmentObject var Dati : Gestione
    var chat : Chat
     @State var messaggio : String = ""
    var body: some View {
        VStack{
            ScrollView {
                ForEach(chat.messaggi){ message in
                    MessageView(utenteMess: Dati.trovaUtenti(telefono: message.telefono)!, messaggio: message).environmentObject(Dati)
                }
            }
            Spacer()
            HStack{
                TextField("  Inserisci messaggio", text: $messaggio)
                    .foregroundColor(.black)
                    .frame(height: 45)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding()
                Button(action: {
                    Dati.AddMessage(txt: messaggio, chat: chat, utente: Dati.Prorpietario)
                }, label: {
                    Image("Mess")
                        .padding(.trailing,20)
                        .foregroundColor(.blue)

                })
                            }
            .background(Color.black.opacity(0.1))
            .cornerRadius(50)
            .padding(.trailing,10)
            .padding(.leading,10)
            
        }
        .background(Color.green.ignoresSafeArea(.all,edges: .all))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:Image(uiImage:Dati.trovaUtenti(telefono: chat.telefono)!.image).resizable().frame(width: 40, height: 40).clipShape(Circle()))
        .navigationBarTitle(Dati.trovaUtenti(telefono: chat.telefono)!.nome)
        .onDisappear{
//                aggiungere la chat se non è presente, peroblema con la creazione.
            Dati.ControlloAggiuntaChat(chat: chat)
            
        }
        

    }
}

struct ChatView_Previews: PreviewProvider {
    static var propri = Utente(nome: "Michele",cognome: "gari", idf: "",nickname: "Pippo",numeroTelefono: "", image:
                                UIImage(imageLiteralResourceName: "Tulipani"))
    static var utente = Utente(nome: "Pippo",cognome: "gari", idf: "",nickname: "Pippo",numeroTelefono: "", image:
                                UIImage(imageLiteralResourceName: "Tulipani"))
    static var messagg01 = Messaggi(testo: "Ciao", data: Date(),telefono: "30")
    static var messagg02 = Messaggi(testo: "Ciao", data: Date(), telefono: "40")
//
    static var chat = Chat(image: "Tulipani", messaggi: [messagg01,messagg02],telefono: "40")
    
    static var previews: some View {
        ChatView(chat: chat).environmentObject(Gestione())
    }
}
