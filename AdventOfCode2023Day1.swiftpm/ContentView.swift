import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: CalibrationViewModel
    
    var body: some View {
        VStack {
            Text("Sum = \(viewModel.calibrationData.getSum())")
            ScrollView {
                ForEach(viewModel.calibrationData) { calibrationData in
                    HStack {
                        Text(calibrationData.input)
                        Spacer()
                        Text("\(calibrationData.firstDigit.1)-\(calibrationData.lastDigit.1)")
                    }
                }
            }
        }.onAppear {
            viewModel.loadData()
        }.padding()
    }
}
