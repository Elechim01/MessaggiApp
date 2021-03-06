//
//  TabButton.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI

struct TabButton: View {
    var image : String
        @Binding var immagineSelezionata : String
        var body:some View{
    
            Button(
                action: {
                immagineSelezionata = image
            }, label: {
                
                ZStack{
                    Circle()
                        .frame(width: 48, height: 48,alignment: .center)
                        .foregroundColor(image == immagineSelezionata ? Color.orange : Color.gray.opacity(0.4))
                    Image(image).frame(alignment:.center)
                }
            })
        }
}

struct TabButton_Previews: PreviewProvider {
    @State  static var immagineSelezionata =  ""
    static var previews: some View {
        TabButton(image: "impostazioni", immagineSelezionata:$immagineSelezionata )
    }
}
