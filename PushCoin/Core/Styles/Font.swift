//
//  Font.swift
//  PushCoin
//
//  Created by Dmitriy Belorusov on 9/8/22.
//

import SwiftUI

extension Font {
    static func appFont(size: CGFloat) -> Font {
        return Font.custom("Inter", size: size)
    }
    
  enum App {
    static let plain = appFont(size: 16).weight(.semibold)
//    static let appTitle = appFont(size: 32).weight(.semibold)
//    static let appSubtitle = appFont(size: 20).weight(.medium)
//    static let appCaption = appFont(size: 14).weight(.regular)
  }
}
 
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("SwiftUI")
//                .font(.appTitle)
//            Text("It is awesome!")
//                .font(.appCaption)
//        }
//    }
//}
