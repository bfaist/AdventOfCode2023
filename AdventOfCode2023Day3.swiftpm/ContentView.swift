import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Sum of Part Numbers: \(viewModel.partNumberSum)")
            ScrollView {
                ForEach(viewModel.schematicItems) { item in
                    HStack {
                        Text("\(item.type.value)")
                        Spacer()
                        Text("\(item.row)")
                        Spacer()
                        Text("\(item.startCol)")
                        Spacer()
                        Text("\(item.endCol)")
                    }
                }
            }
        }.padding()
            .onAppear {
                Task {
                    await viewModel.loadData()
                }
            }
    }
}
