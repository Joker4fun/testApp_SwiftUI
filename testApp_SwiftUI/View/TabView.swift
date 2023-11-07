//
//  ContentView.swift
//  testApp_SwiftUI
//
//  Created by Антон Казеннов on 06.11.2023.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      
      MainTask()
        .tabItem {
          Label("Search", systemImage: "magnifyingglass")
        }
      
      BonusTask()
        .tabItem {
          Label("Viewed", systemImage: "list.bullet.rectangle.portrait" )
        }
    }
  }
}

#Preview {
  ContentView()
}
