import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: GamesViewModel
    
    var body: some View {
        VStack {
            // STAR 1
//            Text("Sum = \(viewModel.games.getSumValidGameIDs())")
//            
//            ScrollView {
//                ForEach(viewModel.games) { game in
//                    HStack {
//                        Text("GAME ID: \(game.id)")
//                        Spacer()
//                        Text("Under Limit: \(game.isGameUnderDiceLimit().description)")
//                    }
//                }
//            }
            
            // STAR 2
            Text("Sum Powers = \(viewModel.games.getSumOfPowers())")
        }.onAppear {
            viewModel.loadData()
        }.padding()
    }
}
