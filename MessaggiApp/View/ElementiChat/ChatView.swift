//
//  ChatView.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI

struct ChatView: View {
//    scaricamento lista di messaggi dal databse
    var utente : Utente
    var chat : [Chat]
     @State var messaggio : String = ""
    var body: some View {
        VStack{
            ScrollView {
                ForEach(chat){ chati in
                    MessageView(chatu: chati)
                    
                }
            }
            Spacer()
            HStack{
                TextField("Inserisci messaggio", text: $messaggio)
                    .foregroundColor(.black)
                    .frame(height: 45)
                    .background(Color.white)
                    .cornerRadius(40)
                    .padding()
                Button(action: {
                    
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
        .navigationBarItems(trailing:Image(uiImage:utente.image).resizable().frame(width: 40, height: 40).clipShape(Circle()))
            .navigationBarTitle(utente.nome)

    }
}

struct ChatView_Previews: PreviewProvider {
    static var utente = Utente(nome: "Pippo", image:
                                UIImage(imageLiteralResourceName: "Tulipani"))
    static var utente1 = Utente(nome: "Michele", image:
                                UIImage(imageLiteralResourceName: "Tulipani"))
    
    static var previews: some View {
        ChatView(utente:utente , chat: [Chat(testo: "ciao", data: Date(), utente:utente),Chat(testo: "Hola", data: Date(), utente: utente1)])
    }
}
