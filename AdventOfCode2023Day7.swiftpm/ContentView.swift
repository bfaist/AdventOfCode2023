import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Total Winnings: \(viewModel.totalWinnings)")
            ScrollView {
                ForEach(viewModel.sortedHands, id: \.self) { hand in
                    HStack {
                        Text(hand.handDescription)
                        Spacer()
                        Text(hand.cards.map({ $0.stringCompareValue }).joined())
                        Spacer()
                        Text(hand.type?.description ?? "")
                    }
                }
            }.padding()
        }
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
    }
}
