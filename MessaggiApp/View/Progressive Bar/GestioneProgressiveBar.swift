//
//  GestioneProgressiveBar.swift
//  MessaggiApp
//
//  Created by Michele Manniello on 27/02/21.
//

import SwiftUI

struct GestioneProgressiveBar: View {
    @EnvironmentObject var dati : Gestione
    @State var progressValue : Float = 0.0
    let timer = Timer.publish(every: 0.01, on: .current, in: .common).autoconnect()
    var body: some View {
        ProgressiveBarView(value: $progressValue).frame( height: 20)
                .padding()
            .onReceive(timer, perform: { _ in
                Controllo()
            })
    }
    func Controllo()  {
        print("🤖 barra \(dati.utenti.count), \(dati.elencoChat.count)")

            if (dati.utenti.count != 0) && (dati.elencoChat.count != 0){
                    let tot = dati.utenti.count + dati.elencoChat.count
                    let ric = dati.presenzaInChatProgress + dati.presenzaInUtentiProgress
                    self.progressValue += Float(ric / tot)
                print("Progresso \(progressValue)")
//                self.progressValue += 0.015
            }
        
//        for _ in 0...1 {
//            self.progressValue += 0.15
//        }
    }
}

struct GestioneProgressiveBar_Previews: PreviewProvider {
    static var previews: some View {
        GestioneProgressiveBar()
    }
}
