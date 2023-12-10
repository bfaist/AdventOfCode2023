//
//  ViewModel.swift
//  AdventOfCode2023Day5
//
//  Created by Robert Faist on 12/5/23.
//

import Foundation

class ViewModel: ObservableObject {
    private var seedData: SeedDataModel?
    
    @Published var seedLocations: [SeedLocation] = []
    @Published var lowestLocation: Int?
    
    private let dataLoader = SeedDataLoader()
    
    @MainActor
    func loadData() async {
        guard let seedData = dataLoader.loadSeedData() else { return }
        
        await withTaskGroup(of: SeedLocation.self) { group in
            for seed in seedData.seeds {
                group.addTask {
                    self.processSeed(ranges: seedData, seed: seed)
                }
            }
            
            for await seedLocation in group {
                seedLocations.append(seedLocation)
            }
        }
        
        let sortedByLocation = seedLocations.sorted(by: { $0.location < $1.location })
        
        lowestLocation = sortedByLocation.first?.location
    }
    
    func processSeed(ranges: SeedDataModel, seed: Int) -> SeedLocation {
        print("SEED \(seed)")
        let soil = find_in_ranges(ranges: ranges.seed_to_soil, findValue: seed)
        print("SOIL \(soil)")
        let fertilizer = find_in_ranges(ranges: ranges.soil_to_fertilizer, findValue: soil)
        print("FERTILIZER \(fertilizer)")
        let water = find_in_ranges(ranges: ranges.fertilizer_to_water, findValue: fertilizer)
        print("WATER \(water)")
        let light = find_in_ranges(ranges: ranges.water_to_light, findValue: water)
        print("LIGHT \(light)")
        let temperature = find_in_ranges(ranges: ranges.light_to_temperature, findValue: light)
        print("TEMP \(temperature)")
        let humidity = find_in_ranges(ranges: ranges.temperature_to_humidity, findValue: temperature)
        print("HUMIDITY \(humidity)")
        let location = find_in_ranges(ranges: ranges.humidity_to_location, findValue: humidity)
        print("LOCATION \(location)")
        
        return SeedLocation(seed: seed,
                            soil: soil,
                            fertilizer: fertilizer,
                            water: water,
                            light: light,
                            temperature: temperature,
                            humidity: humidity,
                            location: location)
    }
    
    func find_in_ranges(ranges: [[Int]], findValue: Int) -> Int {
        for search_range in ranges {
            let sourceRange = search_range[1]..<(search_range[1]+search_range[2])
            let destinationRange = search_range[0]..<(search_range[0]+search_range[2])
            if sourceRange.contains(findValue) {
                for (sourceIndex, sourceValue) in sourceRange.enumerated() where sourceValue == findValue {
                    let destinationIndex = destinationRange.index(destinationRange.startIndex, offsetBy: sourceIndex)
                    let destinationValue = destinationRange[destinationIndex]
                    return destinationValue
                }
            }
        }
        return findValue
    }
}
