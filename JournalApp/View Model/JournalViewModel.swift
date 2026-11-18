import Foundation
import Observation

@Observable
class JournalViewModel {
    // Data
    private(set) var entries: [JournalEntry]

    // Screen state
    var searchText = ""
    var filter: JournalFilter?
    var isAddingEntry = false
    var entryToEdit: JournalEntry?
    var entryToDelete: JournalEntry?
    var isShowingDeleteAlert = false

    private let storage: JournalStorage

    init(storage: JournalStorage = JournalStorage()) {
        self.storage = storage
        self.entries = storage.load()
    }

    // MARK: - What the screen shows
    var visibleEntries: [JournalEntry] {
        let searched = entries.filter { $0.matches(searchText) }
        return filter?.apply(to: searched) ?? searched
    }

    var hasNoEntries: Bool {
        entries.isEmpty
    }

    var hasNoSearchResults: Bool {
        !entries.isEmpty && visibleEntries.isEmpty
    }

    // MARK: - Opening screens
    func startAdding() {
        isAddingEntry = true
    }

    func startEditing(_ entry: JournalEntry) {
        entryToEdit = entry
    }

    func requestDelete(_ entry: JournalEntry) {
        entryToDelete = entry
        isShowingDeleteAlert = true
    }

    func toggleFilter(_ option: JournalFilter) {
        filter = (filter == option) ? nil : option
    }

    // MARK: - Changing data
    func add(title: String, content: String) {
        entries.insert(JournalEntry(title: title, content: content), at: 0)
        storage.save(entries)
    }

    func update(_ entry: JournalEntry, title: String, content: String) {
        guard let index = entries.firstIndex(where: { $0.id == entry.id }) else { return }
        entries[index].title = title
        entries[index].content = content
        storage.save(entries)
    }

    func toggleBookmark(_ entry: JournalEntry) {
        guard let index = entries.firstIndex(where: { $0.id == entry.id }) else { return }
        entries[index].isBookmarked.toggle()
        storage.save(entries)
    }

    func confirmDelete() {
        guard let entry = entryToDelete else { return }
        entries.removeAll { $0.id == entry.id }
        entryToDelete = nil
        storage.save(entries)
    }
}
