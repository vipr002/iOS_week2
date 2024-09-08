import SwiftUI

struct ContactList: View {

    @Binding var contacts: [Contact]
    @Binding var archivedContacts: [ArchivedContact]
    @State var contactToBeArchivedOption: Contact?
    @State var presentSettingsSheet = false
    @State var displayOnlyFavoriteContacts = false
    @State var presentAlert = false

    var body: some View {
        List {
            ForEach($contacts) { $contact in
                if displayOnlyFavoriteContacts && !contact.isFavorite {
                    EmptyView()
                } else {
                    NavigationLink(destination: {
                        ContactDetail(contact: contact)
                    }, label: {
                        ContactCell(contact: contact)
                            .swipeActions(allowsFullSwipe: false) {
                                // Favoritt-funksjon
                                Button("Favorite") {
                                    contact.isFavorite.toggle()
                                }.tint(.green)
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                // Archive-funksjon som setter kontakt for arkivering
                                Button("Archive") {
                                    contactToBeArchivedOption = contact
                                }.tint(.red)
                            }
                    })
                }
            }
        }
        .navigationTitle("My contacts")
        .toolbar {
            Button("Settings") {
                presentSettingsSheet = true
            }
        }
        .sheet(isPresented: $presentSettingsSheet) {
            Toggle(
                "Only display favorite contacts",
                isOn: $displayOnlyFavoriteContacts
            )
            .padding()
        }
        .alert(item: $contactToBeArchivedOption) { contact in
            Alert(
                title: Text("Are you sure?"),
                primaryButton: .destructive(Text("Yes"), action: {
                    archive(contact)
                }),
                secondaryButton: .cancel()
            )
        }
    }

    // MARK: - Private
    
    private func archive(_ contact: Contact?) {
        guard let contact = contact else { return }

        let archivedContact = ArchivedContact(contact: contact, archivedAt: Date())  // Opprett ArchivedContact
        archivedContacts.append(archivedContact)  // Legg til ArchivedContact i listen
        print("Archived contact: \(contact.name) with ID: \(contact.id)")

        if let foundIndex = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts.remove(at: foundIndex)  // Fjern kontakten fra hovedlisten
        }
    }
}

