//
//  CampiDiTesto.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI

struct CampiDiTesto: View {
    var credenzialale : String
    @Binding var valoreTex : String
    var body: some View {
        VStack(alignment: .leading) {
            Text(credenzialale)
                .font(.system(size: 20))
                .frame(height: 30, alignment: .leading)
                .padding(.leading,30)
                .padding(.top,10)
            TextField("Michele", text: $valoreTex)
                .foregroundColor(.black)
                .padding(10)
                .background(Color.gray.opacity(0.6))
                .cornerRadius(50)
                .padding(.leading,20)
                .padding(.trailing,40)
        }
    }
}

struct CampiDiTesto_Previews: PreviewProvider {
    @State static var value  = ""
    static var previews: some View {
        CampiDiTesto(credenzialale: "ciao", valoreTex: $value)
    }
}
