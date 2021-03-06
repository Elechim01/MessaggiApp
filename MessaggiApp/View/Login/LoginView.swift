//
//  LoginView.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var dati : Gestione
    @AppStorage("StatoAccesso") var valoreAggiunto:Int = 0
    @State var telefono : String = ""
    var body: some View {
        ScrollView {
            VStack{
                    Text("Benvenuto")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding(.top)
                    Image("Busta")
                        .padding()
                        .padding(.bottom)
                    ZStack(alignment: .center, content: {
                        VStack {
                            Text("Numero di telefono")
                                .font(.title3)
                                .frame(alignment: .leading)
                                .padding(.horizontal)
                                .padding(.top,10)
    //                            .padding(.leading,5)
                                .padding(.trailing,100)
                            
                            TextField("3381352020", text: $dati.numeroTelefono)
    //                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                .foregroundColor(.black)
                                .padding(.vertical,10)
                                .padding(.horizontal)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(20)
                                .padding(.leading,30)
                                .padding(.trailing,30)
    //                            .padding(.top)
                                .padding(.bottom,10)
                            Button(action: {
                                dati.isLoading.toggle()
                                dati.controlloUtente()
    //                            if(dati.numeroNonValido == false){
    //                                dati.isLoading.toggle()
    //                                dati.Autenticazione()
    //                            }
                            }, label: {
                                Text("Login")
                                    .foregroundColor(.white)
                            })
                            .frame(width: 200, height: 30)
                            .background(Color.red)
                            .clipShape(Capsule())
    //                        .padding(.top)
    //                        .padding(.bottom)
                            
                        Button(action: {
                            valoreAggiunto = 3
                        }, label: {
                            Text("Registrati")
                                .foregroundColor(.white)
                        })
                        .frame(width: 200, height: 30)
                        .background(Color.red)
                        .clipShape(Capsule())
                        .padding(.top,10)
                        .padding(.bottom,10)
                        }
                    })
                    .background(Color.white.cornerRadius(50))
                    .padding(.leading,20)
                    .padding(.trailing,20)
                    .padding(.bottom)

                    Spacer()
            }
        }.background(Color.green.ignoresSafeArea(.all,edges: .all))
          
        }
    }


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(Gestione())
    }
}

struct CustomCorner: Shape {
    var corners : UIRectCorner
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 50, height: 10))
        return Path(path.cgPath)
    }
}
