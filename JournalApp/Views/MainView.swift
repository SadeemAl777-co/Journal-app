import SwiftUI

struct MainView: View {
    @State private var viewModel = JournalViewModel()
    @State private var searchText = ""
    @State private var showEditor = false
    @State private var entryToDelete: JournalEntry?
    @State private var showDeleteAlert = false

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.entries.isEmpty {
                    emptyState
                } else {
                    entryList
                }
            }
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItemGroup {
                    Button("Filter", systemImage: "line.3.horizontal.decrease") { }
                    Button("Add", systemImage: "plus") { showEditor = true }
                }
            }
            .searchable(text: $searchText, prompt: "Search")
            .sheet(isPresented: $showEditor) {
                JournalView { title, content in
                    viewModel.add(title: title, content: content)
                }
                .presentationDragIndicator(.visible)
            }
        }
        .preferredColorScheme(.dark)
    }

    private var emptyState: some View {
        ContentUnavailableView {
            Image(.bookImeag)
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal, count: 3, span: 1, spacing: 0)
            Text("Begin Your Journal")
                .font(.headingM)
                .foregroundStyle(Color.textAccent)
        } description: {
            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.bodyM)
                .foregroundStyle(Color.textPrimary)
        }
    }

    private var entryList: some View {
        List {
            ForEach(viewModel.entries) { entry in
                Section {
                    JournalCard(entry: entry) {
                        viewModel.toggleBookmark(entry)
                    }
                    .listRowBackground(Color.appCard)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            entryToDelete = entry
                            showDeleteAlert = true
                        }
                        .tint(Color.appDestructive)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .alert("Delete Journal?", isPresented: $showDeleteAlert, presenting: entryToDelete) { entry in
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.delete(entry)
            }
        } message: { _ in
            Text("Are you sure you want to delete this journal?")
        }
    }
}

#Preview {
    MainView()
}
