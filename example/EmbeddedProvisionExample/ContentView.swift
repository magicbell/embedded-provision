import SwiftUI
import EmbeddedProvision

struct ContentView: View {
    let provision = try? EmbeddedProvision.load()

    var body: some View {
        VStack {
            if let provision = provision {
                Text("You're app was signed with: \(provision.name)")
            } else {
                Text("No embedded provision found. Are you running on Simulator?")
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
