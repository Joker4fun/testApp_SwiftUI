//
//  ContactModel.swift
//  testApp_SwiftUI
//
//  Created by Антон Казеннов on 06.11.2023.
//

import Foundation
import Contacts
import SwiftUI

enum PermissionsError: Identifiable {
  var id: String { UUID().uuidString }
  case authError
  case fetchError
  
  
  
  var description: String {
    switch self {
    case .authError:
      return "Please change permissions in settings."
    case .fetchError:
      return "Error to fetch contacts."
    }
  }
}
  
  struct Contact: Identifiable, Hashable {
    
    let contact:CNContact
    let id = UUID()
    let givenName: String
    let familyName: String
    let phoneNumbers: String
    let contactImage: UIImage
    var chosenOne:Bool = false
    
    init(contact: CNContact) {
      self.contact = contact
      self.givenName = contact.givenName
      self.familyName = contact.familyName
      self.phoneNumbers = contact.phoneNumbers.map(\.value).first?.stringValue ?? ""
      switch contact.imageDataAvailable {
      case true:
        self.contactImage = UIImage(data: contact.imageData!)!
      case false:
        self.contactImage = UIImage(systemName: "person.and.background.striped.horizontal")!
      }
      
    }
  }
  
  
