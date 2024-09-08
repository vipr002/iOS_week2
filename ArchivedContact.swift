//
//  ArchivedContact.swift
//  Forelesning3
//
//  Created by Victoria Prigel on 08/09/2024.
//

import Foundation

struct ArchivedContact: Identifiable {
    var id: UUID { contact.id }  // contact.id som identifikator
    let contact: Contact
    let archivedAt: Date
}
