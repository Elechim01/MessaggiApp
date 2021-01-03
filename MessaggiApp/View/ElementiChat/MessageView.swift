//
//  ChatView.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI

struct MessageView: View {
    @EnvironmentObject var Dati : Gestione
//    var propietario : Utente
     var utenteMess : Utente
    var messaggio : Messaggi
    var body: some View {
            HStack{
                if utenteMess.nome == Dati.Prorpietario.nome{Spacer(minLength: 0)}
            
                VStack(alignment: utenteMess.nome == Dati.Prorpietario.nome ?.leading :.trailing,spacing:5){
                    Text("\(messaggio.testo)")
                        .fontWeight(.semibold)
                        .frame(height: 10)
                        .foregroundColor(.black)
                        .padding(.top,20)
                        .padding(.leading,30)
                        .padding(.trailing,30)
                        .padding(.bottom,15)
                        .background(Color.white)
                        .clipShape(Capsule())
                        
                    Text(messaggio.data,style: .time)
                        .frame(alignment: utenteMess.nome == Dati.Prorpietario.nome ?.leading :.trailing )
            }
                
                if utenteMess.nome != Dati.Prorpietario.nome {Spacer(minLength: 0)}
            }
//            .background(Color.blue)
            .padding()
            .onAppear{
                print(utenteMess.nickname)
            }
//            .background(Color.green)
//            .ignoresSafeArea(.all,edges: .all)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(utenteMess: Utente(nome: "", cognome: "", nickname: "", numeroTelefono: "", image: #imageLiteral(resourceName: "Busta")), messaggio: Messaggi(testo: "Hello", data: Date(),telefono : "40")).environmentObject(Gestione())
    }
}
