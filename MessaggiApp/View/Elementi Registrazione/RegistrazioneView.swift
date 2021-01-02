//
//  RegistrazioneView.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI

struct RegistrazioneView: View {
    @State var nome : String = ""
    @State var cognome : String = ""
    @State var nckname : String = ""
    @State var numerotelefono : String = ""
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            VStack{
                Text("Registrazione")
                    .font(.system(size: 50))
//                    .padding(.top,50)
                Image("Busta")
                    .padding()
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
//                        .frame(height:UIScreen.main.bounds.height/2.1)
                        .cornerRadius(30)
                        .padding(.leading,5)
                        .padding(.trailing,5)
                        .padding(.bottom)
                    
                    VStack(alignment:.leading){
                        CampiDiTesto(credenzialale: "Nome", valoreTex: $nome)
                        CampiDiTesto(credenzialale: "Cognome", valoreTex: $cognome)
                        CampiDiTesto(credenzialale: "Nickname", valoreTex: $nckname)
                        CampiDiTesto(credenzialale: "Telefono", valoreTex: $numerotelefono)
                    
                        Button(action: {
                            
                        }, label: {
                            Text("Conferma")
                                .foregroundColor(.black)
                                .frame(width: 200, height: 40, alignment: .center)
                                .background(Color.red)
                        })
                        .frame(alignment: .trailing)
                        .clipShape(Capsule())
                        .padding(.top,15)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.bottom,30)
                    }
                    
                }
//                Spacer()
            }
        }
        
    }
}

struct RegistrazioneView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrazioneView()
    }
}
