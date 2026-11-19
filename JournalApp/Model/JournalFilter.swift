import Foundation

enum JournalFilter: String, CaseIterable, Identifiable {
    case bookmark = "Sort by Bookmark"
    case entryDate = "Sort by Entry Date"

    var id: String { rawValue }

    func apply(to entries: [JournalEntry]) -> [JournalEntry] {
        switch self {
        case .bookmark:
            let newestFirst = entries.sorted { $0.date > $1.date }
            return newestFirst.filter { $0.isBookmarked } + newestFirst.filter { !$0.isBookmarked }
        case .entryDate:
            return entries.sorted { $0.date > $1.date }
            
            
        }
    }
}
