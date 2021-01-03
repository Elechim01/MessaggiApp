//
//  contatti.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI

struct contatti: View {
    var utente : Utente
    var body: some View {
            HStack(alignment:.center){
                ZStack{
                    Circle()
                        .stroke(Color.black,lineWidth: 2)
                        .frame(width: 41, height: 41)
                        
                    Image(uiImage: utente.image)
                    .resizable()
                    .frame(width:41,height: 41)
                    .clipShape(Circle())
                }
                .padding()
                Text(utente.nome)
                    .foregroundColor(.black)
                    .font(.title)
                    .font(.body)
                    .frame(alignment:.center)
                    .padding()
                Spacer()
            }
    }
}
struct contatti_Previews: PreviewProvider {
    static var previews: some View {
        contatti(utente : Utente(nome: "Michele", cognome: "Manniello", nickname: "Miky", numeroTelefono: "+393381356237", image: UIImage(imageLiteralResourceName: "Tulipani")))
    }
}
