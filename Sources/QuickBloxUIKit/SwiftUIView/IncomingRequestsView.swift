import SwiftUI

struct IncomingRequestsView: View {
    @EnvironmentObject var rosterManager: RosterManager

    var body: some View {
        NavigationView {
            List {
                ForEach(rosterManager.pendingRequests, id: \.self) { userID in
                    HStack {
                        Text("User \(userID) wants to chat")
                        Spacer()
                        Button("Accept") {
                            rosterManager.acceptRequest(from: userID)
                        }
                        .buttonStyle(.borderedProminent)

                        Button("Reject") {
                            rosterManager.rejectRequest(from: userID)
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            .navigationTitle("Chat Requests")
        }
    }
}
