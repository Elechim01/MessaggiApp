//
//  ChatView.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI
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
                            if((messagge.destinatario == Dati.Prorpietario.numeroTelefono && messagge.mittente == Dati.trovaUtenti(telefono: chat.telefono)!.numeroTelefono)||(messagge.destinatario == Dati.trovaUtenti(telefono: chat.telefono)!.numeroTelefono && messagge.mittente == Dati.Prorpietario.numeroTelefono)){
                                
                            MessageView(utenteMess: Dati.trovaUtenti(telefono: messagge.mittente)!, messaggio: messagge).environmentObject(Dati)
                                .onAppear{
//                                    Filtro i messaggi che sono diretti a noi
                                    let mess = Dati.FiltroMessaggi(altroUtente: Dati.trovaUtenti(telefono: chat.telefono)!)
                                    if messagge.id == mess.last!.id && scrolled{
                                        reader.scrollTo(mess.last!.id,anchor:.bottom)
                                        scrolled = true
                                    }
                                }
                            }
                        }.onChange(of: Dati.messaggi, perform: { value in
                            let mess = Dati.FiltroMessaggi(altroUtente: Dati.trovaUtenti(telefono: chat.telefono)!)
                            reader.scrollTo(mess.last!.id,anchor:.bottom)
                        })
                    }
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
                    Dati.AddMessage(messag: Messaggi(testo: messaggio, idf: "", data: Date(), mittente: Dati.Prorpietario.numeroTelefono, destinatario: chat.telefono))
                    messaggio = ""
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
        .navigationBarItems(
            trailing:
                WebImage(url: URL(string: Dati.trovaUtenti(telefono:chat.telefono)!.image ))
                                .resizable().frame(width: 40, height: 40).clipShape(Circle()))
        .navigationBarTitle(Dati.trovaUtenti(telefono: chat.telefono)!.nome)
        .onDisappear{
//                aggiungere la chat se non è presente, peroblema con la creazione.
            Dati.ControlloAggiuntaChat(chat: chat)
            
        }
        
//        Dati.FiltroMessaggi(altroUtente: Dati.trovaUtenti(telefono: chat.telefono)!
    }
}

struct ChatView_Previews: PreviewProvider {
    static var propri = Utente(nome: "Michele",cognome: "gari", idf: "",nickname: "Pippo",numeroTelefono: "40", image:
                                "Tulipani")
    static var utente = Utente(nome: "Pippo",cognome: "gari", idf: "",nickname: "Pippo",numeroTelefono: "30", image:
                               "Tulipani")
    static var messagg01 = Messaggi(testo: "Ciao",idf: "", data: Date(), mittente:"", destinatario: "")
    static var messagg02 = Messaggi(testo: "Ciao",idf: "", data: Date(), mittente:"", destinatario: "")
//
    static var chat = Chat(image: "Tulipani", messaggi: [messagg01,messagg02],telefono: "30", idf: "")
    
    static var previews: some View {
        ChatView(chat: chat).environmentObject(Gestione())
    }
}
