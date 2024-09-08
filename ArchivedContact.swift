//
//  ArchivedContact.swift
//  Forelesning3
//
//  Created by Victoria Prigel on 08/09/2024.
//

import Foundation

struct ArchivedContact: Identifiable {
    let id = UUID()
    let contact: Contact
    let archivedAt: Date
}

private func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    return formatter.string(from: date)
}
