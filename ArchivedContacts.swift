import SwiftUI

struct ArchivedContacts: View {
    
    @Binding var archivedContacts: [ArchivedContact]
    @Binding var contacts: [Contact]
    @State private var showAlert = false
    @State private var alertAction: AlertAction?
    @State private var selectedContact: Contact?
    
    
    enum AlertAction {
        case restore(Contact)
        case delete(Contact)
    }
    
    
    var body: some View {
        List {
            if archivedContacts.isEmpty {
                Text("You have no archived contacts")
            } else {
                ForEach(archivedContacts) { archivedContact in
                    ArchivedCell(contact: archivedContact.contact)
                       
                        .swipeActions(allowsFullSwipe: false) {
                            Button("Restore") {
                                selectedContact = archivedContact.contact
                                alertAction = .restore(archivedContact.contact)
                                showAlert = true
                                print("Restore button pressed for contact: \(archivedContact.contact.name)")
                            }.tint(.blue)
                        }
                       
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button("Delete") {
                                selectedContact = archivedContact.contact
                                alertAction = .delete(archivedContact.contact)
                                showAlert = true
                            }.tint(.red)
                        }
                }
            }
        }
        .navigationTitle("Archived Contacts")
        
        // https://developer.apple.com/documentation/swiftui/view/alert(_:ispresented:presenting:actions:message:)-29bp4
        .alert("Are you sure?", isPresented: $showAlert, presenting: alertAction) { action in
            switch action {
                
                case .restore(let contact):
                Button("Yes", role: .destructive) {
                    print("Restore confirmed for contact: \(contact.name)")
                    restore(contact)
                }
                Button("Cancel", role: .cancel) {}
                
                case .delete(let contact):
                Button("Yes", role: .destructive) {
                    print("Delete confirmed for contact: \(contact.name)")
                    delete(contact)
                }
                Button("Cancel", role: .cancel) {}
            }
        } message: { action in
            switch action {
                
                case .restore(let contact):
                Text("Do you want to restore \(contact.name)?")
                
                case .delete(let contact):
                Text("Do you want to delete \(contact.name)?")
            }
        }
    }
    

    
    private func restore(_ contact: Contact) {
        if let foundIndex = archivedContacts.firstIndex(where: { $0.contact.id == contact.id }) {
            let archivedContact = archivedContacts[foundIndex]
            contacts.append(archivedContact.contact)
            archivedContacts.remove(at: foundIndex)
            print("Restored contact: \(archivedContact.contact.name)")
        } else {
            print("Contact not found in archive")
        }
    }
    
    
    private func delete(_ contact: Contact) {
        if let foundIndex = archivedContacts.firstIndex(where: { $0.contact.id == contact.id }) {
            archivedContacts.remove(at: foundIndex)
            print("Deleted contact: \(contact.name)")
        }
    }
}
