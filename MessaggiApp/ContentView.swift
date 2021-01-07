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
    @StateObject var gestionedati = Gestione()
    @AppStorage("StatoAccesso") var valoreAggiunto:Int = 0
    var body: some View {
        ZStack{
            if valoreAggiunto == 2{
                NavigationView{
                    SceltaMultipla().environmentObject(gestionedati)
                    .navigationTitle("")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
                }
//                    Prednere spunto per tabbar
//                    if trovato != true{ SceltaMultipla()}
            }
            if((gestionedati.valoreAggiunto == 0) || (gestionedati.valoreAggiunto == 1)){
                LoginView().environmentObject(gestionedati)
            }
            if(gestionedati.valoreAggiunto == 3){
                RegistrazioneView().environmentObject(gestionedati)
                
            }
            if(gestionedati.isLoading){
                LoadingView()
            }
            
        }
        .alert(isPresented: $gestionedati.alert, content: {
            Alert(title: Text("Erroe"), message: Text(gestionedati.alertMessage), dismissButton: .default(Text("OK")))
        })
        .alert(isPresented: $gestionedati.numeroNonValido, content: {
            Alert(title: Text("Attenzione!!⚠️"), message: Text("Valore non valido"), dismissButton: .default(Text("OK")))
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
