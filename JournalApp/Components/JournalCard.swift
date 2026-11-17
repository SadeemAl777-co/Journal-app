import SwiftUI

struct JournalCard: View {
    let entry: JournalEntry
    var onBookmark: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(entry.title)
                    .font(.titleCard)
                    .foregroundStyle(Color.textAccent)

                Spacer()

                Button(action: onBookmark) {
                    Image(systemName: entry.isBookmarked ? "bookmark.fill" : "bookmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 29)
                        .foregroundStyle(Color.textAccent)
                }
                .buttonStyle(.plain)
            }

            Text(entry.date.formatted(date: .numeric, time: .omitted))
                .font(.captionM)
                .foregroundStyle(Color.textSecondary)

            Text(entry.content)
                .font(.bodyM)
                .foregroundStyle(Color.textPrimary)
        }
    }
}
