import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    var body: some View {
        VStack {
            Text("Answer: \(viewModel.answer)")
            ForEach(viewModel.computedRaces) { race in
                Text("Race Time: \(race.maxTime)")
                Text("Record: \(race.recordDistance)")
                Text("Ways to Win: \(race.waysToWin)")
                Divider()
            }
        }.onAppear {
            // TASK 1
            // viewModel.findAnswerTask1()
            // TASK 2
            viewModel.findAnswerTask2()
        }
    }
}
