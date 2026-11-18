import SwiftUI

struct MainView: View {
    @State private var viewModel = JournalViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.hasNoEntries {
                    emptyState
                } else if viewModel.hasNoSearchResults {
                    ContentUnavailableView.search(text: viewModel.searchText)
                } else {
                    entryList
                }
            }
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItemGroup {
                    Menu("Filter", systemImage: "line.3.horizontal.decrease") {
                        ForEach(JournalFilter.allCases) { option in
                            Button(option.rawValue) {
                                viewModel.toggleFilter(option)
                            }
                        }
                    }
                    Button("Add", systemImage: "plus") {
                        viewModel.startAdding()
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .sheet(isPresented: $viewModel.isAddingEntry) {
                JournalView { title, content in
                    viewModel.add(title: title, content: content)
                }
                .presentationDragIndicator(.visible)
            }
            .sheet(item: $viewModel.entryToEdit) { entry in
                JournalView(entry: entry) { title, content in
                    viewModel.update(entry, title: title, content: content)
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
            ForEach(viewModel.visibleEntries) { entry in
                Section {
                    JournalCard(entry: entry) {
                        viewModel.toggleBookmark(entry)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.startEditing(entry)
                    }
                    .listRowBackground(Color.appCard)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            viewModel.requestDelete(entry)
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(Color.appDestructive)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .alert("Delete Journal?", isPresented: $viewModel.isShowingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.confirmDelete()
            }
        } message: {
            Text("Are you sure you want to delete this journal?")
        }
    }
}

#Preview {
    MainView()
}
