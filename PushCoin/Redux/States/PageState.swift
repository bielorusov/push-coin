//
//  PageState.swift
//  PushCoin
//
//  Created by Dmitriy Belorusov on 9/7/22.
//

import Foundation

struct PageState: ReduxState {
  static var initialState: PageState {
    .init(currentPage: .home, previousPage: .home)
  }
  
  let currentPage: Page
  let previousPage: Page
}
