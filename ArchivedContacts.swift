import SwiftUI

struct ArchivedContacts: View {

    @Binding var archivedContacts: [Contact]
    @Binding var contacts: [Contact]
    @State var contactToBeRestoredOption: Contact?
    @State var contactToBeDeletedOption: Contact?

    var body: some View {
        List {
            if archivedContacts.isEmpty {
                Text("You have no archived contacts")
            } else {
                ForEach(archivedContacts) { contact in
                    ArchivedCell(contact: contact)
                        .swipeActions(allowsFullSwipe: false) {
                            Button("Restore") {
                                contactToBeRestoredOption = contact
                            }.tint(.blue)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button("Delete") {
                                contactToBeDeletedOption = contact
                            }.tint(.red)
                        }
                }
            }
        }
        .navigationTitle("Archived Contacts")
        // Restore alert
        .alert(item: $contactToBeRestoredOption) { contact in
            Alert(
                title: Text("Are you sure you want to restore \(contact.name)?"),
                primaryButton: .destructive(Text("Yes"), action: {
                    handleContact(contact, action: .restore) // Kaller restore-funksjonen
                }),
                secondaryButton: .cancel()
            )
        }
        // Delete alert
        .alert(item: $contactToBeDeletedOption) { contact in
            Alert(
                title: Text("Are you sure you want to delete \(contact.name)?"),
                primaryButton: .destructive(Text("Yes"), action: {
                    handleContact(contact, action: .delete) // Kaller delete-funksjonen
                }),
                secondaryButton: .cancel()
            )
        }
    }
    
    enum ContactAction {
        case restore
        case delete
    }

    private func handleContact(_ contact: Contact?, action: ContactAction) {
        guard let contact = contact else { return }
        
        if let foundIndex = archivedContacts.firstIndex(where: { $0.id == contact.id }) {
            
            switch action {
            case .restore:
                contacts.append(contact)  // Flytt til hovedlisten
                print("moved to contacts: \(contact.name)")
                archivedContacts.remove(at: foundIndex)
                print("removed from archive: \(contact.name)")
                
            case .delete:
                archivedContacts.remove(at: foundIndex)
                print("removed from archive: \(contact.name)")
            }
        }
    }
}
    

// ---- Alternativ ----


/*
 
 // Funksjon som flytter kontakt tilbake til hovedlisten
 private func restore(_ contact: Contact?) {
     guard let contact = contact else { return }
     contacts.append(contact)
     if let foundIndex = archivedContacts.firstIndex(where: { $0.id == contact.id }) {
         archivedContacts.remove(at: foundIndex)
     }
 }

 // Funksjon som sletter kontakt fra arkiverte kontakter
 private func delete(_ contact: Contact?) {
     guard let contact = contact else { return }
     if let foundIndex = archivedContacts.firstIndex(where: { $0.id == contact.id }) {
         archivedContacts.remove(at: foundIndex)
     }
 }

 }
 */
