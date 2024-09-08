
import Foundation

struct Contact: Identifiable {

    let id: UUID = UUID()
    let image: SomeSfSymbols
    let name: String
    let phoneNumber: String
    var isFavorite: Bool = false
    var isArchived: Bool = false
    

    static let mocks = [
        Contact(
            image: SomeSfSymbols.menucard,
            name: "John Menu",
            phoneNumber: "901 34 483"
        ),
        Contact(
            image: SomeSfSymbols.arrowupandpersonrectangleturnright,
            name: "Donna ArrowUp",
            phoneNumber: "934 12 117"
        ),
        Contact(
            image: SomeSfSymbols.figureracquetball,
            name: "Mike Racquet",
            phoneNumber: "329 12 239"
        ),
        Contact(
            image: SomeSfSymbols.linkbadgeplus,
            name: "Tonny Badge",
            phoneNumber: "913 14 753"
        ),
        Contact(
            image: SomeSfSymbols.trayfill,
            name: "Bob Tray",
            phoneNumber: "989 84 213"
        )
    ]

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }
}
