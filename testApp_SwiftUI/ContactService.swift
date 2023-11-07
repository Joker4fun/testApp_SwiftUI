//
//  ContactService.swift
//  testApp_SwiftUI
//
//  Created by Антон Казеннов on 06.11.2023.
//

import Foundation
import Contacts
import SwiftUI


final class FetchContacts {
  
  var contacts:[Contact] = []
  private var store = CNContactStore()

  func makeRequest(completion: @escaping([Contact]?) -> Void) {
  
      self.contacts = []
      //ключи для поиска по полям
      let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey, CNContactImageDataAvailableKey, CNContactThumbnailImageDataKey]
      let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
      request.sortOrder = CNContactSortOrder.givenName
    DispatchQueue.global().async {
      
      do {
        try self.store.enumerateContacts(with: request, usingBlock: { (contact, _ ) in
          self.contacts.append(Contact(contact: contact))
          completion(self.contacts)

        })
        
      } catch {
        print("Failed to enumerate contacts:", error)
      }
    }
  
  }
}

