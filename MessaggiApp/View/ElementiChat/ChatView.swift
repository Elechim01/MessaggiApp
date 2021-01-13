//
//  ChatView.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct ChatView: View {
//    scaricamento lista di messaggi dal databse
    @EnvironmentObject var Dati : Gestione
    var chat : Chat
     @State var messaggio : String = ""
    @State var scrolled = false
    var body: some View {
        VStack{
            ScrollViewReader { reader in
                ScrollView {
                    VStack(spacing:10) {
                        ForEach(Dati.messaggi){ messagge in
                            if((messagge.destinatario == Dati.Prorpietario.numeroTelefono &&
                                    messagge.mittente == Dati.trovaDestinatario(ut: chat.ut, ut1: chat.ut1)!.numeroTelefono ) ||
                               (messagge.destinatario == Dati.trovaDestinatario(ut: chat.ut, ut1: chat.ut1)!.numeroTelefono
                                    && messagge.mittente == Dati.Prorpietario.numeroTelefono)){
                                
                            MessageView(utenteMess: Dati.trovaUtenti(telefono: messagge.mittente), messaggio: messagge).environmentObject(Dati)
                                .onAppear{
//                                    Filtro i messaggi che sono diretti a noi
                                    let mess = Dati.FiltroMessaggi(altroUtente: Dati.trovaDestinatario(ut: chat.ut, ut1: chat.ut1)!)
                                    print("☠️data messaggio \(messagge.data), mess \(mess.last!.data)")
                                    if messagge.id == mess.last!.id && !scrolled{
                                        reader.scrollTo(mess.last!.id,anchor:.bottom)
                                        scrolled = true
                                    }
                                }
                            }
                        }.onChange(of: Dati.messaggi, perform: { value in
                            let mess = Dati.FiltroMessaggi(altroUtente: Dati.trovaDestinatario(ut: chat.ut, ut1: chat.ut1)!)
                            reader.scrollTo(mess.last!.id,anchor:.bottom)
                        })
                    }
                }
            }
            Spacer()
            HStack{
                TextEditor(text: $messaggio)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .frame(height: 45)
                    .background(Color.white)
                    .cornerRadius(20)
                
                Button(action: {
                    Dati.AddMessage(messag: Messaggi(testo: messaggio, idf: "", data: Date(), mittente: Dati.Prorpietario.numeroTelefono, destinatario: Dati.trovaDestinatario(ut: chat.ut, ut1: chat.ut1)!.numeroTelefono))
                    messaggio = ""
                }, label: {
                    Image("Mess")
                        .padding(.trailing,5)
                        .foregroundColor(.blue)

                })
            }
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(50)
            .padding(.trailing,10)
            .padding(.leading,10)
            .padding(.top,20)
            
        }
        .background(Color.green.ignoresSafeArea(.all,edges: .all))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing:
                Image(uiImage:Dati.trovaDestinatario(ut: chat.ut, ut1: chat.ut1)!.image!)
//                Image("Busta")
                .resizable().frame(width: 40, height: 40).clipShape(Circle())
        )
        .navigationBarTitle(Dati.trovaDestinatario(ut: chat.ut, ut1: chat.ut1)!.nome)
        .onDisappear{
//                aggiungere la chat se non è presente, peroblema con la creazione.
            chat .image = Dati.trovaUtenti(telefono: Dati.TrovaDestinatarioChat(chat: chat)).image
            Dati.ControlloAggiuntaChat(chat: chat)
            
        }
//        Dati.FiltroMessaggi(altroUtente: Dati.trovaUtenti(telefono: chat.telefono)!
    }
}

struct ChatView_Previews: PreviewProvider {
    static var propri = Utente(nome: "Michele",cognome: "gari", idf: "",nickname: "Pippo",numeroTelefono: "40", percorsoimage:
                                "Tulipani")
    static var utente = Utente(nome: "Pippo",cognome: "gari", idf: "",nickname: "Pippo",numeroTelefono: "30", percorsoimage:
                               "Tulipani")
    static var messagg01 = Messaggi(testo: "Ciao",idf: "", data: Date(), mittente:"", destinatario: "")
    static var messagg02 = Messaggi(testo: "Ciao",idf: "", data: Date(), mittente:"", destinatario: "")
//
    static var chat = Chat(percorsoimage: "Tulipani", messaggi: [messagg01,messagg02],ut: "30",ut1: "", idf: "")
    
    static var previews: some View {
        ChatView(chat: chat).environmentObject(Gestione())
    }
}
