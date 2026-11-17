import Foundation

enum JournalFilter: String, CaseIterable, Identifiable {
    case bookmark = "Sort by Bookmark"
    case entryDate = "Sort by Entry Date"

    var id: String { rawValue }
}
