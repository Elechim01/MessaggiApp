//
//  ContentView.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI

struct ContentView: View {
//    View di gestione
//    @AppStorage("qualcosa") var status =
    var trovato = true
    
    var body: some View {
        ZStack{
            if trovato{
                NavigationView{
                   SceltaMultipla()
                    .navigationTitle("")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
                }
//                    Prednere spunto per tabbar
//                    if trovato != true{ SceltaMultipla()}
            }else{
                LoginView(telefono: "33334")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
