//
//  SceltaMultipla.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI

struct SceltaMultipla: View {
    
    @EnvironmentObject var gestionedati : Gestione
    
    var utente = Utente(nome: "Pippo", cognome: "", idf: "", nickname: "", numeroTelefono: "", percorsoimage:  "Tulipani")
    @State var selectTabbar: String = "messaggi"
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    var body: some View {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            Color.green.ignoresSafeArea(.all,edges: .all)
            TabView(selection: $selectTabbar){
                    Home().environmentObject(gestionedati)
                        .tag("messaggi")
                Impostazioni().environmentObject(gestionedati)
                        .tag("impostazioni")
                UtenteView().environmentObject(gestionedati)
                        .tag("utente")
                    }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all,edges: .bottom)
            HStack(spacing:0){
                           ForEach(tabs,id:\.self){ image in
                            TabButton(image: image, immagineSelezionata: $selectTabbar)
                               if image != tabs.last{
                                   Spacer(minLength: 0)
                               }
                           }
                       }
            .frame(height: 55)
                .padding(.horizontal,25)
                .padding(.vertical,5)
                .background(Color.white)
                .clipShape(Capsule())
                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
                .padding(.horizontal)
        })
        .ignoresSafeArea(.keyboard,edges: .bottom)
    }
        
    }

var tabs = ["messaggi","impostazioni","utente"]

struct SceltaMultipla_Previews: PreviewProvider {
    static var previews: some View {
        SceltaMultipla().environmentObject(Gestione())
    }
}
