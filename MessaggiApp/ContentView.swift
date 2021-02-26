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
        VStack {
            ZStack {
                ZStack{
                    if(valoreAggiunto == 2){
                        if(gestionedati.Caricamento() == true){
                                NavigationView{
                                SceltaMultipla().environmentObject(gestionedati)
                                .navigationTitle("")
                                .navigationBarTitleDisplayMode(.inline)
                                .navigationBarHidden(true)
                            }
                        }else{
                            Text("Caricamento chat")
                                .onAppear{
                                    gestionedati.isLoading = false
                                    print("🤖",valoreAggiunto)
                                    gestionedati.LeggiChat()
                                    gestionedati.Lettura()
                                    gestionedati.LeggiMessaggio()
                                }
                        }
        //                    Prednere spunto per tabbar
        //                    if trovato != true{ SceltaMultipla()}
                    }
                    
                    if(valoreAggiunto == 0){
                        LoginView().environmentObject(gestionedati)
                    }
                    if(valoreAggiunto == 1){
                        LoginView().environmentObject(gestionedati)
                    }
                    if(valoreAggiunto == 3){
                        RegistrazioneView().environmentObject(gestionedati)
                        
                    }
                    if(gestionedati.alert == true){
                        AlertView(testo: "Errore", messaggio: gestionedati.alertMessage, risposta: $gestionedati.alert)
                    }
                    if(gestionedati.numeroNonValido == true){
                        AlertView(testo: "Attenzione!!⚠️", messaggio: "Valore non valido", risposta: $gestionedati.numeroNonValido)
                    }
                    if(gestionedati.eliminazioneChatToggle == true){
                        EliminaChatView().environmentObject(gestionedati)
                    }
//                    if(gestionedati.isLoading){
//                        LoadingView()
//                    }
                if(gestionedati.selezionaAcquisizioneImge){
                    CatturaImmagine(image:$gestionedati.acquisizioneImage , isShow: $gestionedati.selezionaAcquisizioneImge)
                        .onDisappear{
    //                        Mostriamo schemrata di caricamento:
                            gestionedati.registrazione.toggle()
                            gestionedati.CaricaImmagine()
                            
                    }
                }
                    if(valoreAggiunto != 2 && valoreAggiunto != 3 && valoreAggiunto != 0 && valoreAggiunto != 1){
                        Text("Errore")
                    }
                }
            }
        }
//        .alert(isPresented: $gestionedati.alert, content: {
//            Alert(title: Text("Erroe"), message: Text(gestionedati.alertMessage), dismissButton: .default(Text("OK")))
//        })
//        .alert(isPresented: $gestionedati.numeroNonValido, content: {
//            Alert(title: Text("Attenzione!!⚠️"), message: Text("Valore non valido"), dismissButton: .default(Text("OK")))
//        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
