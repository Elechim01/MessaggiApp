//
//  ProgressiveBarView.swift
//  MessaggiApp
//
//  Created by Michele Manniello on 27/02/21.
//

import SwiftUI

struct ProgressiveBarView: View {
    @Binding var value : Float
    var body: some View {
         GeometryReader{geometry in
            ZStack(alignment:.leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                Rectangle().frame(
                    width: min(CGFloat(self.value)*geometry.size.width,geometry.size.width),
                    height: geometry.size.height)
                    .foregroundColor(Color.blue)
            }
        }.cornerRadius(45.0)
    }
}

struct ProgressiveBarView_Previews: PreviewProvider {
    @State static var prog  : Float = 1.0
    static var previews: some View {
        ProgressiveBarView(value: $prog)
    }
}
