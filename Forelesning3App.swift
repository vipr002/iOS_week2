import SwiftUI

@main
struct Forelesning3App: App {
    
    @State private var contacts: [Contact] = Contact.mocks
    @State private var archivedContacts: [Contact] = []

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationStack {
                    ContactList(contacts: $contacts, archivedContacts: $archivedContacts) // Sender bindinger til ContactList
                }
                .tabItem { Text("First") }
                
                PickerView()
                    .tabItem { Text("Second") }
                
                NavigationStack {
                    ArchivedContacts(archivedContacts: $archivedContacts, contacts: $contacts) // Sender bindinger til ArchivedContacts
                }
                .tabItem { Text("Third")}
            }
        }
    }
}
