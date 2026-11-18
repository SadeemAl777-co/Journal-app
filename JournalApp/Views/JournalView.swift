import SwiftUI

struct JournalView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: JournalEditorViewModel
    @FocusState private var isTyping: Bool

    var onSave: (String, String) -> Void

    init(entry: JournalEntry? = nil, onSave: @escaping (String, String) -> Void) {
        _viewModel = State(initialValue: JournalEditorViewModel(entry: entry))
        self.onSave = onSave
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    TextField("", text: $viewModel.title,
                              prompt: Text("Title").foregroundStyle(Color.textSecondary.opacity(0.5)))
                        .font(.headingL)
                        .foregroundStyle(Color.textAccent)
                        .focused($isTyping)

                    Text(viewModel.formattedDate)
                        .font(.captionM)
                        .foregroundStyle(Color.textSecondary)

                    TextField("", text: $viewModel.content,
                              prompt: Text("Type your Journal...").foregroundStyle(Color.textSecondary.opacity(0.5)),
                              axis: .vertical)
                        .font(.bodyL)
                        .foregroundStyle(Color.textPrimary)
                }
                .padding()
            }
            .background(Color.appCard.ignoresSafeArea())
            .tint(Color.textAccent)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", systemImage: "xmark") {
                        viewModel.requestClose { dismiss() }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", systemImage: "checkmark") {
                        onSave(viewModel.title, viewModel.content)
                        dismiss()
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color.appPrimary)
                    .disabled(!viewModel.hasChanges)
                }
            }
            .alert("Are you sure you want to discard changes on this journal?",
                   isPresented: $viewModel.isShowingDiscardAlert) {
                Button("Discard Changes", role: .destructive) { dismiss() }
                Button("Keep Editing", role: .cancel) { }
            }
            .interactiveDismissDisabled(viewModel.hasChanges)
            .onAppear { isTyping = true }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    JournalView { _, _ in }
}
