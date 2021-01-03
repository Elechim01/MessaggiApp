//
//  LoginView.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI

struct LoginView: View {
    @State var telefono : String
    var body: some View {
            VStack{
                Text("Benvenuto")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .padding()
                Image("Busta")
                    .padding()
                ZStack(alignment: .center, content: {
                    VStack {
                        TextField("numero di telefono", text: $telefono)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.black)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(20)
                            .padding(.leading,30)
                            .padding(.trailing,30)
                            .padding(.top)
                            .padding(.bottom)
                        Button(action: {

                        }, label: {
                            Text("Login")
                                .foregroundColor(.white)
                        })
                        .frame(width: 200, height: 30)
                        .background(Color.red)
                        .clipShape(Capsule())
                        .padding(.top)
                        .padding(.bottom)

                    Button(action: {

                    }, label: {
                        Text("Registrati")
                            .foregroundColor(.white)
                    })
                    .frame(width: 200, height: 30)
                    .background(Color.red)
                    .clipShape(Capsule())
                    .padding(.top)
                    .padding(.bottom)
                    }
                })
                .background(Color.white.cornerRadius(50))
                .padding(.leading,8)
                .padding(.trailing,8)
                .padding(.bottom)

                Spacer()
            }.background(Color.green.ignoresSafeArea(.all,edges: .all))
        }
    }


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(telefono: "")
    }
}

struct CustomCorner: Shape {
    var corners : UIRectCorner
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 50, height: 10))
        return Path(path.cgPath)
    }
}