import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            if let lowestLocation = viewModel.lowestLocation {
                Text("Lowest Location: \(lowestLocation)")
            }
            ScrollView {
                ForEach(viewModel.seedLocations) { seedLocation in
                    VStack(alignment: .leading) {
                        Text("Seed: \(seedLocation.seed)")
                            .font(.headline)
                        Text("Soil: \(seedLocation.soil)")
                        Text("Fertilizer: \(seedLocation.fertilizer)")
                        Text("Water: \(seedLocation.water)")
                        Text("Light: \(seedLocation.light)")
                        Text("Temperature: \(seedLocation.temperature)")
                        Text("Humidity: \(seedLocation.humidity)")
                        Text("Location: \(seedLocation.location)")
                            .font(.headline)
                        Divider()
                            .frame(height: 3)
                    }.padding()
                }
            }
        }.onAppear {
            Task {
                await viewModel.loadData()
            }
        }.padding(.top, 10)
    }
}
