import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Steps: \(viewModel.steps)")
        }.onAppear {
            Task {
                await viewModel.loadData()
                await viewModel.followPaths()
            }
        }
    }
}
