import SwiftUI

struct JournalView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var content = ""
    @State private var showDiscardAlert = false
    @FocusState private var isTyping: Bool

    var onSave: (String, String) -> Void

    private var hasText: Bool {
        !title.isEmpty || !content.isEmpty
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    TextField("", text: $title,
                              prompt: Text("Title").foregroundStyle(Color.textSecondary.opacity(0.5)))
                        .font(.headingL)
                        .foregroundStyle(Color.textAccent)
                        .focused($isTyping)

                    Text(Date.now.formatted(date: .numeric, time: .omitted))
                        .font(.captionM)
                        .foregroundStyle(Color.textSecondary)

                    TextField("", text: $content,
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
                        if hasText {
                            showDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", systemImage: "checkmark") {
                        onSave(title, content)
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.appPrimary)
                    .foregroundStyle(Color.appBackground)
                    .disabled(!hasText)
                }
            }
            .alert("Are you sure you want to discard changes on this journal?",
                   isPresented: $showDiscardAlert) {
                Button("Discard Changes", role: .destructive) { dismiss() }
                Button("Keep Editing", role: .cancel) { }
            }
            .interactiveDismissDisabled(hasText)
            .onAppear { isTyping = true }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    JournalView { _, _ in }
}
