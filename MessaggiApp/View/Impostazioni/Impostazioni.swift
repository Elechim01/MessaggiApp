//
//  Impostazioni.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI

struct Impostazioni: View {
    @AppStorage("StatoAccesso") var valoreAggiunto:Int = 0
    @EnvironmentObject var gestione : Gestione
    var body: some View {
        ZStack {
            VStack{
                    Button(action: {
                        valoreAggiunto = 0
                    }, label: {
                        Text("LogOut")
                            .padding()
                    })
                    Text("\(gestione.Prorpietario.nome)")
                    Text("\(gestione.Prorpietario.cognome)")
                    Text("\(gestione.Prorpietario.nickname)")
                    Text("\(gestione.Prorpietario.numeroTelefono)")
                    Button(action: {
                        gestione.selezionaAcquisizioneImge.toggle()
                    }, label: {
                        Text("Scegli image")
                    })
                Image(uiImage: gestione.acquisizioneImage ?? UIImage(imageLiteralResourceName: "Busta"))
                        .resizable()
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white,lineWidth: 4))
                        .shadow(radius: 10)
            }
        }
    }
}

struct Impostazioni_Previews: PreviewProvider {
    static var previews: some View {
        Impostazioni().environmentObject(Gestione())
    }
}
