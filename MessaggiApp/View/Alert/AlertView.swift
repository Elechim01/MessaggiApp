//
//  AlertView.swift
//  MessaggiApp
//
//  Created by Michele Manniello on 26/02/21.
//

import SwiftUI

struct AlertView: View {
    var testo : String
    var messaggio : String
    @Binding var risposta : Bool
    var body: some View {
        
        VStack(alignment: .center) {
            Text("\(testo)")
                .font(.system(size: 20))
                .padding(.top,5)
            
            Text("\(messaggio)")
                .font(.system(size: 13))
                .lineLimit(2)
                .padding(.top,5)
                .padding(.leading,2)
                .padding(.trailing,2)
            Divider()
            Button(action: {
                risposta.toggle()
            }, label: {
                Text("OK")
            })
            .frame(width: 140, height: 40)
            .clipShape(Capsule())
            .padding(.top,5)
        }
        .frame(width: 200,height: 140)
        .background(Color.white)
        .cornerRadius(30)
    }
}

struct AlertView_Previews: PreviewProvider {
    @State static var alert : Bool = true
    static var previews: some View {
        AlertView(testo: "Ciao", messaggio: "Hola", risposta: $alert)
    }
}
