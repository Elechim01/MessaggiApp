//
//  UtenteView.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//
//in qiesta view dovra esserci una lista di utenti, una vola cliccati,
//si crera una chat,
import SwiftUI

struct UtenteView: View {
    @EnvironmentObject var gestioneDati : Gestione
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea(.all,edges: .all)
            VStack {
                Text("Utenti")
                    .font(.system(size: 40))
                    .foregroundColor(.black)
                ForEach(gestioneDati.utenti){ utenti in
                    if(utenti.numeroTelefono != gestioneDati.Prorpietario.numeroTelefono){
                        NavigationLink(
                        destination: ChatView(chat: Chat(percorsoimage: utenti.percorsoimage, messaggi: [], ut: utenti.numeroTelefono,ut1: gestioneDati.Prorpietario.numeroTelefono, idf: "")).environmentObject(gestioneDati)
//                            con il Disappear non ha problemi
                        ,label: {
                    SezioneUtenteView(utente: utenti)
                        .frame(height: 55)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .padding(.leading,20)
                        .padding(.trailing,20)
                        })
                        }
                    }
                Spacer()
            }
        }
    }
}

struct UtenteView_Previews: PreviewProvider {
    static var previews: some View {
        UtenteView().environmentObject(Gestione())
    }
}
