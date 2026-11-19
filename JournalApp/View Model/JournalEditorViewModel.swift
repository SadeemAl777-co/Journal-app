import Foundation
import Observation

@Observable
class JournalEditorViewModel {
    var title: String
    var content: String
    var isShowingDiscardAlert = false

    private let original: JournalEntry?

    init(entry: JournalEntry? = nil) {
        self.original = entry
        self.title = entry?.title ?? ""
        self.content = entry?.content ?? ""
    }

    var formattedDate: String {
        (original?.date ?? Date.now).formatted(date: .numeric, time: .omitted)
    }

    var hasChanges: Bool {
        title != (original?.title ?? "") || content != (original?.content ?? "")
    }

    func requestClose(onClose: () -> Void) {
        if hasChanges {
            isShowingDiscardAlert = true
        } else {
            onClose()
        }
        var canSave: Bool {
            !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
}
