import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: GamesViewModel
    
    var body: some View {
        VStack {
            Text("Sum = \(viewModel.games.getSumValidGameIDs())")
            
            ScrollView {
                ForEach(viewModel.games) { game in
                    HStack {
                        Text("GAME ID: \(game.id)")
                        Spacer()
                        Text("Under Limit: \(game.isGameUnderDiceLimit().description)")
                    }
                }
            }
        }.onAppear {
            viewModel.loadData()
        }.padding()
    }
}
