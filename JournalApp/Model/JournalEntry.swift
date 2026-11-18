import Foundation

struct JournalEntry: Identifiable, Codable {
    var id = UUID()
    var title: String
    var content: String
    var date = Date()
    var isBookmarked = false

    var formattedDate: String {
        date.formatted(date: .numeric, time: .omitted)
    }

    func matches(_ query: String) -> Bool {
        query.isEmpty
        || title.localizedCaseInsensitiveContains(query)
        || content.localizedCaseInsensitiveContains(query)
    }
}
