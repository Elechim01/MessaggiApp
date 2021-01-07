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
            
        }
    }
}

struct Impostazioni_Previews: PreviewProvider {
    static var previews: some View {
        Impostazioni().environmentObject(Gestione())
    }
}
