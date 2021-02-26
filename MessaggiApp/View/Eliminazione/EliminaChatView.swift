//
//  EliminaChatView.swift
//  MessaggiApp
//
//  Created by Michele Manniello on 26/02/21.
//

import SwiftUI

struct EliminaChatView: View {
    @EnvironmentObject var gestionedati : Gestione
    var body: some View {
//        Creiamo un alert con il cestino
        VStack(alignment: .center) {
            HStack{
                Image(systemName:"trash.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red)
                    .padding(.leading,5)
                Text("Elimina riga")
                    .foregroundColor(.white)
                    .font(.title2)
            }
            .padding(.top,10)
            .onTapGesture {
                gestionedati.EliminaChat()
                gestionedati.eliminazioneChatToggle = false
            }
            Divider().background(Color.white)
            Button(action: {
                gestionedati.eliminazioneChatToggle = false
            }, label: {
                Text("Annulla")
                    .font(.title2)
            })
            .padding(.bottom,10)
            
        }
        .background(Color.black)
        .frame(width: 190, height: 100)
        .cornerRadius(15)
    }
}

struct EliminaChatView_Previews: PreviewProvider {
    static var previews: some View {
        EliminaChatView()
    }
}
