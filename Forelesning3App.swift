import SwiftUI

@main
struct Forelesning3App: App {
    
    @State private var contacts: [Contact] = Contact.mocks
    @State private var archivedContacts: [ArchivedContact] = []

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationStack {
                    ContactList(contacts: $contacts, archivedContacts: $archivedContacts)
                }
                .tabItem { Text("First") }
                
                PickerView()
                    .tabItem { Text("Second") }
                
                NavigationStack {
                    ArchivedContacts(archivedContacts: $archivedContacts, contacts: $contacts)
                }
                .tabItem { Text("Third")}
            }
        }
    }
}

