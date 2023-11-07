//
//  ContactViewModel.swift
//  testApp_SwiftUI
//
//  Created by Антон Казеннов on 06.11.2023.
//

import Foundation
import SwiftUI
import Contacts

final class ContactViewModel:ObservableObject {
  
  @Published var contacts:[Contact] = []
  @Published var searchText: String = ""
  @Published var selectedContacts:Set<Contact> = []
  private var fetchService = FetchContacts()
  @Published var permissionsError: PermissionsError? = .none
  @Published var didError = false

  
  init() {
    permissionStatus()
  }
  
  // Переменная с фильтрованным списком контактов
  var filteredContact: [Contact] {
    guard !searchText.isEmpty else { return contacts }
    return contacts.filter{ contact in
      contact.givenName.lowercased().contains(self.searchText.lowercased()) ||
      contact.familyName.lowercased().contains(self.searchText.lowercased()) ||
      contact.phoneNumbers.contains(self.searchText)
    }
  }
  // Проверка прав доступа
  func permissionStatus() {
    switch CNContactStore.authorizationStatus(for: .contacts) {
    case .notDetermined, .restricted, .denied:
      CNContactStore().requestAccess(for: .contacts, completionHandler: { granted, error in
        if granted {
          self.makeContactModel()
        } else if let error = error {
          self.openSettings()
          self.didError = true
          DispatchQueue.main.async {
            self.permissionsError = .authError
            print("Error to fetch Contacts - \(error.localizedDescription)")
          }
        }
      })
    case .authorized:
      self.makeContactModel()
    @unknown default:
      self.makeContactModel()
    }
  }
  
  // Открывем настройки для получения доступа к контактам
  func openSettings() {
    permissionsError = .none
    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
    if UIApplication.shared.canOpenURL(settingsURL) { UIApplication.shared.open(settingsURL)}
  }
  
  func makeContactModel() {
    fetchService.makeRequest { model in
      guard let model = model else { 
        self.permissionsError = .fetchError
        return
      }
      DispatchQueue.main.async {
        self.contacts = model
      }
    }
  }
  
}
