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
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    @EnvironmentObject var gestioneDati : Gestione
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea(.all,edges: .all)
            ScrollView{
            VStack {
                Text("Utenti")
                    .font(.system(size: 40))
                    .foregroundColor(.black)
                    ForEach(gestioneDati.utenti){ utenti in
                        if(utenti.numeroTelefono != gestioneDati.Prorpietario.numeroTelefono){
                            NavigationLink(
                                destination: ChatView(chat: Chat(percorsoimage: utenti.percorsoimage, messaggi: [], ut: utenti.numeroTelefono,ut1: gestioneDati.Prorpietario.numeroTelefono, idf: ""),utenteNuovo : true).environmentObject(gestioneDati)
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
                }
                Spacer()
            }.padding(.bottom,edge!.bottom + 70)
        }
    }
}

struct UtenteView_Previews: PreviewProvider {
    static var previews: some View {
        UtenteView().environmentObject(Gestione())
    }
}
