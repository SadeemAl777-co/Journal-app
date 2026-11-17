import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            MainView()
        } else {
            splash
                .task {
                    try? await Task.sleep(for: .seconds(2))
                    withAnimation { isActive = true }
                }
        }
    }

    private var splash: some View {
        VStack {
            Image(.bookIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 90)

            Text("Journali")
                .font(.headingL)
                .foregroundStyle(Color.textPrimary)

            Text("Your thoughts, your story")
                .font(.bodyM)
                .foregroundStyle(Color.textSecondary)
        }
    }
}

#Preview {
    SplashView()
        .preferredColorScheme(.dark)
}
