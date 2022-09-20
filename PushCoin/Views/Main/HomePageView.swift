//
//  HomePageView.swift
//  PushCoin
//
//  Created by Dmitriy Belorusov on 9/19/22.
//

import SwiftUI

struct HomePageView: View {
  var body: some View {
    ZStack {
      Color.App.bg.ignoresSafeArea()
      
      VStack {
        Text("3000 P")
          .foregroundColor(.white)
          .font(Font.App.largeMedium)
          .offset(x: 0, y: -UIScreen.main.bounds.height/6 )
      }
      
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: Geometry.Size.padding) {
          Spacer()
            .frame(height: UIScreen.main.bounds.height * 2/3)
          
          ForEach(sectionItemsList.indices, id: \.self) { index in
            HorizontalSectionsView(sections: sectionItemsList[index])
          }
          
          Spacer()
            .frame(height: 70)
        }
      }
    }
  }
}

struct HorizontalSectionsView: View {
  var sections: [Section]
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false){
      HStack(alignment: .center) {
        ForEach(sections) { section in
          SectionView(section: section)
            .frame(width: UIScreen.main.bounds.width)
        }
      }
    }
  }
}


struct SectionView: View {
  var section: Section
  
  var body: some View {
    section.image
      .clipShape(RoundedRectangle(cornerRadius: 30))
  }
}


struct Section: Identifiable {
  var id = UUID()
  var title: String
  var text: String
  var image: Image
}

// AsyncImage(url: URL(string: "https://www.hackingwithswift.com/img/paul.png"))
let sectionItemsList = [
  [
    Section(title: "Section 1 title", text: "Text of section 1", image: Image("section_1")),
    Section(title: "Section 12 title", text: "Text of section 12", image: Image("section_1")),
    Section(title: "Section 13 title", text: "Text of section 13", image: Image("section_1"))
  ],
  
  [
    Section(title: "Section 2 title", text: "Text of section 2", image: Image("section_2"))
  ],
  
  [
    Section(title: "Section 3 title", text: "Text of section 3", image: Image("section_3")),
    Section(title: "Section 31 title", text: "Text of section 31", image: Image("section_3")),
    Section(title: "Section 32 title", text: "Text of section 32", image: Image("section_3")),
    Section(title: "Section 323 title", text: "Text of section 33", image: Image("section_3"))
  ],
  [
    Section(title: "Section 4 title", text: "Text of section 4", image: Image("section_4"))
  ]
]




struct HomePageView_Previews: PreviewProvider {
  static var previews: some View {
    HomePageView()
  }
}
