//
//  SezioneUtenteView.swift
//  MessaggiApp
//
//  Created by Michele on 03/01/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SezioneUtenteView: View {
    var utente : Utente
    var body: some View {
        ZStack {
//            Color.green
            HStack() {
                
                ZStack {
                    Circle()
                        .stroke(Color.black,lineWidth:  2)
                        .frame(width: 40, height: 40, alignment: .center)
                    if  utente.image != ""{
                    WebImage(url: URL(string:utente.image))
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .clipShape(Circle())
                        
                    }else{
                        Image("Busta")
                            .frame(width: 40, height: 40, alignment: .center)
                            .clipShape(Circle())
                    }
                    
//                        .padding(.leading)
//                        .padding(.top)
//                        .padding(.bottom)
//                        .padding(.leading)
                }.padding(.leading,20)
                Text(utente.nickname)
//                    .font(.title3)
                    .foregroundColor(.black)
                    .font(.system(size: 25))
                    .padding(.leading)
                Spacer()
            }.background(Color.white)
//            .frame(height: 70)
        }
        
    }
}

struct SezioneUtenteView_Previews: PreviewProvider {
    static var previews: some View {
        SezioneUtenteView(utente: Utente(nome: "m", cognome: "", idf: "", nickname: "pippo", numeroTelefono: "", image: "Busta"))
    }
}
