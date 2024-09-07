//
//  ArchivedCell.swift
//  Forelesning3
//
//  Created by Victoria Prigel on 07/09/2024.
//

import Foundation
import SwiftUI

import SwiftUI

struct ArchivedCell: View {

    var contact: Contact

    var body: some View {
        HStack {
            Text(contact.name)
            Spacer()
        }
        .background(Color.white)
    }
}

#Preview {
    ArchivedCell(contact: Contact.mocks[0])
}
