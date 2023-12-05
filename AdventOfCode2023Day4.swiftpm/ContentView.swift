import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Total Score: \(viewModel.cardTotalScore)")
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.cardsWithScores) { card in
                        Text("CARD \(card.id) \(card.haveWinningMatch!.description) \(card.score!)")
                    }
                }
            }
        }.onAppear {
            Task {
                await viewModel.loadDataTask1()
            }
        }
    }
}
