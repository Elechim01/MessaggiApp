//
//  Home.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI

struct Home: View {
    
    @State var cerca : String = ""
//    var Proprietario = Utente(nome: "Michele", cognome: "", nickname: "", numeroTelefono: "", image: UIImage(imageLiteralResourceName: "Tulipani"))
    @EnvironmentObject var gestioneDati : Gestione
//    var elementi :  [Chat]
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
//        NavigationView {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {Color.green.ignoresSafeArea(.all,edges: .all)
                VStack {
                            Text("Messaggi")
                                .font(.system(size: 40))
                            HStack{
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(.leading,15)
                                    TextField("Cerca", text: $cerca)
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .padding(.trailing,30)
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(30)

                            }.background(Color.white)
                            .background(Color.gray.opacity(0.06),alignment: .center)
                            .cornerRadius(30)
                            .padding(.leading,10)
                            .padding(.trailing,10)
                            .padding(.top,10)
                            
    //
                                ForEach(gestioneDati.RicercaElementi(cerca: cerca)){ ele in
                                        NavigationLink(
                                            destination: ChatView(chat: ele, utenteNuovo: false)
                                                .environmentObject(gestioneDati)
                                            ,label: {
                                                contatti(utente: gestioneDati.trovaDestinatario(ut: ele.ut, ut1: ele.ut1)!)
                                                    .frame(height:50)
                                                    .background(Color.white)
                                                    .cornerRadius(50)
                                                    .padding(.top,10)
                                                    .padding(.leading,10)
                                                    .padding(.trailing,10)
                                                  
                                            })
                                            .onTapGesture(count :2) {
                                            gestioneDati.chatDaEiminare = ele
                                            gestioneDati.eliminazioneChatToggle.toggle()
                                            
//                                                    Implementare l'elimina della chat.
                                            print("🤖Idf \(ele.idf)")
//                                                    gestioneDati.EliminaChat(chat: ele)
                                            print("ho premuto a lungo")
                                    }
                                }
                                
    //                        .padding(.bottom,edge!.bottom - 70)
                }
    //
            }
        }.padding(.bottom,edge!.bottom + 70)
//            .background(Color.green)
//            .ignoresSafeArea(.all,edges: .all)
//        }
    }
}

struct Home_Previews: PreviewProvider {
    static var utente = Utente(nome: "Pippo", cognome: "", idf: "", nickname: "", numeroTelefono: "", percorsoimage: "Tulipani")
    static var previews: some View {
        Home().environmentObject(Gestione())
    }
}
