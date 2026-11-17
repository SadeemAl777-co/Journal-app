import Foundation
import Observation

@Observable
class JournalViewModel {
    var entries: [JournalEntry] = []

    private let storageKey = "journalEntries"

    init() {
        load()
    }

    func add(title: String, content: String) {
        entries.insert(JournalEntry(title: title, content: content), at: 0)
        save()
    }

    func toggleBookmark(_ entry: JournalEntry) {
        guard let index = entries.firstIndex(where: { $0.id == entry.id }) else { return }
        entries[index].isBookmarked.toggle()
        save()
    }

    func delete(_ entry: JournalEntry) {
        entries.removeAll { $0.id == entry.id }
        save()
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(entries) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let saved = try? JSONDecoder().decode([JournalEntry].self, from: data)
        else { return }
        entries = saved
    }
}
