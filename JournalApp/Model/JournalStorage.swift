import Foundation

struct JournalStorage {
    private let key = "journalEntries"

    func load() -> [JournalEntry] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let entries = try? JSONDecoder().decode([JournalEntry].self, from: data)
        else { return [] }
        return entries
    }

    func save(_ entries: [JournalEntry]) {
        guard let data = try? JSONEncoder().encode(entries) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}
