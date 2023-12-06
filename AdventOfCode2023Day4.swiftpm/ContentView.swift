import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
//            Text("Total Score: \(viewModel.cardTotalScore)")
//            ScrollView {
//                VStack(alignment: .leading) {
//                    ForEach(viewModel.cardsWithScores) { card in
//                        Text("CARD \(card.id) \(card.haveWinningMatch!.description) \(card.score!)")
//                            .font(.callout)
//                    }
//                }
//            }
            Text("Total Card Count \(viewModel.cardCountSum)")
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.cardIdCountMap.sorted(by: <), id: \.key) { key, value in
                        Text("CARD \(key) COUNT: \(value)")
                    }
                }
            }
        }.padding()
         .onAppear {
            Task {
//                 await viewModel.loadDataTask1()
                await viewModel.loadDataTask2()
            }
        }
    }
}
