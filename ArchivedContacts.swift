import SwiftUI

struct ArchivedContacts: View {
    
    @Binding var archivedContacts: [ArchivedContact]
    @Binding var contacts: [Contact]
    @State var contactToBeRestoredOption: Contact?
    @State var contactToBeDeletedOption: Contact?
    
    var body: some View {
        List {
            if archivedContacts.isEmpty {
                Text("You have no archived contacts")
            } else {
                ForEach(archivedContacts) { archivedContact in
                    ArchivedCell(contact: archivedContact.contact)
                        .swipeActions(allowsFullSwipe: false) {
                            Button("Restore") {
                                contactToBeRestoredOption = archivedContact.contact
                                print("Restore button pressed for contact: \(archivedContact.contact.name)")
                            }.tint(.blue)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button("Delete") {
                                contactToBeDeletedOption = archivedContact.contact
                            }.tint(.red)
                        }
                }
            }
        }
        .navigationTitle("Archived Contacts")
        .alert(item: $contactToBeRestoredOption) { contact in
            Alert(
                title: Text("Are you sure you want to restore \(contact.name)?"),
                primaryButton: .destructive(Text("Yes"), action: {
                    print("Restore confirmed for contact: \(contact.name)")
                    restore(contact)
                }),
                secondaryButton: .cancel()
            )
        }
        
        .alert(item: $contactToBeDeletedOption) { contact in
            Alert(
                title: Text("Are you sure you want to delete \(contact.name)?"),
                primaryButton: .destructive(Text("Yes"), action: {
                    print("Delete confirmed for contact: \(contact.name)")
                    delete(contact)
                }),
                secondaryButton: .cancel()
            )
        }
    }
    
    enum ContactAction {
        case restore
        case delete
    }

    func handleContact(_ contact: Contact?, action: ContactAction) {
        guard let contact = contact else {
            print("Contact is nil")
            return
        }
        
        switch action {
        case .restore:
            restore(contact)
        case .delete:
            delete(contact)
        }
    }

    
    private func restore(_ contact: Contact) {
        // Finn indeksen til den arkiverte kontakten
        if let foundIndex = archivedContacts.firstIndex(where: { $0.contact.id == contact.id }) {
            // Hent den arkiverte kontakten fra listen
            let archivedContact = archivedContacts[foundIndex]
            
            // Legg til kontakten tilbake i hovedlisten
            contacts.append(archivedContact.contact)
            
            // Fjern kontakten fra arkivlisten
            archivedContacts.remove(at: foundIndex)
            
            print("Restored contact: \(archivedContact.contact.name)")
        } else {
            print("Contact not found in archive")
        }
    }


    private func delete(_ contact: Contact) {
        if let foundIndex = archivedContacts.firstIndex(where: { $0.contact.id == contact.id }) {
            archivedContacts.remove(at: foundIndex)
        }
    }
}
   
    
 /*   private func handleContact(_ contact: Contact?, action: ContactAction) {
        guard let contact = contact else {
            print("Contact is nil")
            return
        }

        print("Handling contact: \(contact.name) with ID: \(contact.id) for action: \(action)")

        switch action {
            
        case .restore:
            print("Trying to restore: \(contact.name)")

            for archivedContact in archivedContacts {
                print("Checking archived contact: \(archivedContact.contact.name) with ID: \(archivedContact.contact.id)")
                print("Does \(contact.id) == \(archivedContact.contact.id)? \(contact.id == archivedContact.contact.id)")
            }

            if let foundIndex = archivedContacts.firstIndex(where: { archivedContact in
                let isMatch = archivedContact.contact.id == contact.id
                print("Comparing \(archivedContact.contact.id) with \(contact.id): \(isMatch)")
                return isMatch
            }) {
                print("Found contact to restore at index \(foundIndex)")
                let archivedContact = archivedContacts[foundIndex]

                // Legg til animasjon og print for UI-oppdatering
                withAnimation {
                    print("Adding \(archivedContact.contact.name) to contacts")
                    contacts.append(archivedContact.contact)
                    print("Restored contact: \(archivedContact.contact.name)")
                    print("Contacts after restore: \(contacts.map { $0.name })")

                    print("Removing \(archivedContact.contact.name) from archived contacts")
                    archivedContacts.remove(at: foundIndex)  // Fjern kontakten fra arkivet
                    print("Archived contacts after restore: \(archivedContacts.map { $0.contact.name })")
                }

                print("UI should now reflect the restored contact")
            } else {
                print("Could not find contact in archivedContacts for restoration")
            }

         case .delete:
            print("Trying to delete: \(contact.name)")

            // Sjekk om kontakten finnes i archivedContacts
            if let foundIndex = archivedContacts.firstIndex(where: { $0.contact.id == contact.id }) {
                archivedContacts.remove(at: foundIndex)
                print("Removed from archive: \(contact.name)")
                print("Archived contacts after delete: \(archivedContacts.map { $0.contact.name })")
            } else {
                print("Could not find contact in archivedContacts for deletion")
            }
        }
    }
    */
