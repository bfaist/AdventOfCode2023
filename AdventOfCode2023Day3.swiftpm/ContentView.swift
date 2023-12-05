import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            // Star 1
//            Text("Sum of Part Numbers: \(viewModel.partNumberSum)")
//            ScrollView {
//                ForEach(viewModel.schematicItems) { item in
//                    HStack {
//                        Text("\(item.type.value)")
//                        Spacer()
//                        Text("\(item.row)")
//                        Spacer()
//                        Text("\(item.startCol)")
//                        Spacer()
//                        Text("\(item.endCol)")
//                    }
//                }
            
              // Star 2
            Text("Gear Ratios: \(viewModel.gearRatioSum)")
        }.padding()
            .onAppear {
                Task {
                    // STAR 1
                    // await viewModel.loadDataTask1()
                    // STAR 2
                    await viewModel.loadDataTask2()
                }
            }
    }
}
