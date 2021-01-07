//
//  LoadingView.swift
//  MessaggiApp
//
//  Created by Michele on 07/01/21.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.2).ignoresSafeArea(.all,edges: .all)
            ProgressView()
                .padding(20)
                .background(Color.white)
                .cornerRadius(20)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
