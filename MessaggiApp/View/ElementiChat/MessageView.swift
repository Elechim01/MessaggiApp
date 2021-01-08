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
                        .foregroundColor(.black)
                        .padding(.top,10)
                        .padding(.leading,10)
                        .padding(.trailing,10)
                        .padding(.bottom,10)
                        .background(Color.white)
                        .clipShape(Capsule())
                        
                    Text(messaggio.data,style: .time)
                        .font(.system(size: 15))
//                        .padding(.horizontal)
//                        .padding(.trailing,utenteMess.numeroTelefono == Dati.Prorpietario.numeroTelefono ?  0 : 95)
//                        .padding(.leading,utenteMess.numeroTelefono == Dati.Prorpietario.numeroTelefono ?  95: 0)
//
//                        .frame(width: (UIScreen.main.bounds.width/3) * 2)
                    
                }
                .frame(width:(UIScreen.main.bounds.width/3)*2 ,alignment: utenteMess.numeroTelefono == Dati.Prorpietario.numeroTelefono ?.trailing :.leading)
                
                .padding(.trailing,10)
                .padding(.leading,10)
                if utenteMess.numeroTelefono != Dati.Prorpietario.numeroTelefono {
                    Spacer(minLength: 0)
                    
                }
            }
            //            .background(Color.blue)
//            .padding()
            .onAppear{
                print(utenteMess.nickname)
//                print(messaggio.telefono)
            }
            .background(Color.green)
//            .ignoresSafeArea(.all,edges: .all)
    }
    
}

//(UIScreen.main.bounds.width/3)*2

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(utenteMess: Utente(nome: "", cognome: "", idf: "", nickname: "", numeroTelefono: "", image: "Busta"), messaggio: Messaggi(testo: "ciaoooooooooo",idf: "", data: Date(), mittente:"", destinatario: "")).environmentObject(Gestione())
    }
}
