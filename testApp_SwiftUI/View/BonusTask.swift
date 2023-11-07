//
//  BonusTask.swift
//  testApp_SwiftUI
//
//  Created by Антон Казеннов on 06.11.2023.
//

import SwiftUI
import Combine

struct BonusTask: View {
  @StateObject var viewModel = ContactViewModel()
  
  var body: some View {
    
    VStack(spacing: 0) {
      SelectedView(viewModel: viewModel)
        .frame(height: 70)
      NavigationStack {
        Divider()
        List($viewModel.contacts, id: \.id) { $contacts in
          
          HStack {
            Image(systemName: contacts.chosenOne ?  "circle.fill" : "circle")
              .foregroundStyle(.blue)
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
          .onTapGesture {
            contacts.chosenOne.toggle()
            if contacts.chosenOne != false {
              viewModel.selectedContacts.insert(contacts)
            }
          }
        }
      }
      //Строка поиска
      .searchable(text: $viewModel.searchText)
      .alert("Error", isPresented: $viewModel.didError, actions: {
        Button("Settings", role: .cancel, action: {
          viewModel.openSettings()
        })
        
        Button("Cancel", role: .destructive, action: {})
      }, message: {
        Text(viewModel.permissionsError?.description ?? "unknown error")
      })
    }
  }
  
  
  struct SelectedView : View {
    @ObservedObject var viewModel:ContactViewModel
    var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 10) {
          ForEach(viewModel.selectedContacts.sorted(by: {$0.givenName > $1.givenName}), id: \.self) { contacts in
            Image(uiImage: contacts.contactImage)
              .resizable()
              .frame (width: 70, height: 70)
              .clipShape(Circle(), style: FillStyle())
          }
        }
      }
    }
  }
}
