//
//  ChatView.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI

struct MessageView: View {
    var chatu : Chat
    var body: some View {
            HStack{
                if chatu.utente.nome == "Michele"{Spacer(minLength: 0)}
            
                VStack(alignment: chatu.utente.nome == "Michele" ?.leading :.trailing,spacing:5){
                    Text("\(chatu.testo)")
                        .fontWeight(.semibold)
                        .frame(height: 10)
                        .foregroundColor(.black)
                        .padding(.top,20)
                        .padding(.leading,30)
                        .padding(.trailing,30)
                        .padding(.bottom,15)
                        .background(Color.white)
                        .clipShape(Capsule())
                        
                    Text(chatu.data,style: .time)
            }
                
                if chatu.utente.nome != "Michele"{Spacer(minLength: 0)}
            }
//            .background(Color.blue)
            .padding()
//            .background(Color.green)
//            .ignoresSafeArea(.all,edges: .all)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var utente1 = Utente(nome: "Michele", image:
                                UIImage(imageLiteralResourceName: "Tulipani"))
    static var previews: some View {
        MessageView(chatu: Chat(testo: "pippo", data: Date(), utente: Utente(nome: "Michele", image: UIImage(imageLiteralResourceName: "Tulipani"))))
    }
}
