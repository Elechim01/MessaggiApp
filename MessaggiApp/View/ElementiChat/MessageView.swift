//
//  ChatView.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI

struct MessageView: View {
    @EnvironmentObject var Dati : Gestione
//    CONTROLLO FATTO SUL MITTENTE
//    var propietario : Utente
     var utenteMess : Utente
    var messaggio : Messaggi
    var body: some View {
            HStack{
                if utenteMess.numeroTelefono == Dati.Prorpietario.numeroTelefono{
                    Spacer(minLength: 0)
                }
                VStack(alignment: utenteMess.numeroTelefono == Dati.Prorpietario.numeroTelefono ?.leading :.trailing,spacing:5){
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
                        .frame(alignment: utenteMess.numeroTelefono == Dati.Prorpietario.numeroTelefono ?.leading :.trailing )
            }
                
                if utenteMess.numeroTelefono != Dati.Prorpietario.numeroTelefono {
                    Spacer(minLength: 0)
                    
                }
            }
//            .background(Color.blue)
            .padding()
            .onAppear{
                print(utenteMess.nickname)
//                print(messaggio.telefono)
            }
//            .background(Color.green)
//            .ignoresSafeArea(.all,edges: .all)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(utenteMess: Utente(nome: "", cognome: "", idf: "", nickname: "", numeroTelefono: "", image: "Busta"), messaggio: Messaggi(testo: "Ciao",idf: "", data: Date(), mittente:"", destinatario: "")).environmentObject(Gestione())
    }
}
