//
//  MainTask.swift
//  testApp_SwiftUI
//
//  Created by Антон Казеннов on 06.11.2023.
//

import SwiftUI
import Combine

struct MainTask: View {
  @StateObject var viewModel = ContactViewModel()
  
  
  var body: some View {
    NavigationStack {
      Divider()
      List(viewModel.filteredContact, id: \.id) { contacts in
        HStack {
          Image(uiImage: contacts.contactImage)
            .resizable()
            .frame (width: 60, height: 60)
            .clipShape(Circle(), style: FillStyle())
          
          VStack(alignment: .leading, spacing: 10) {
            Text("\(contacts.givenName)" + " " + "\(contacts.familyName)" )
              .font(.headline)
            Text("\(contacts.phoneNumbers)")
              .foregroundStyle(.gray)
              .font(.subheadline)
          }
          .multilineTextAlignment(.leading)
        }
      }
    }
    //Строка поиска
    .searchable(text: $viewModel.searchText)
  }
}

#Preview {
  MainTask()
}
