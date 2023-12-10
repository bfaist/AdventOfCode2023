//
//  SeedDataModel.swift
//  AdventOfCode2023Day5
//
//  Created by Robert Faist on 12/5/23.
//

import Foundation

struct SeedDataModel: Codable {
    let seeds: [Int]
    let seed_to_soil: [[Int]]
    let soil_to_fertilizer: [[Int]]
    let fertilizer_to_water: [[Int]]
    let water_to_light: [[Int]]
    let light_to_temperature: [[Int]]
    let temperature_to_humidity: [[Int]]
    let humidity_to_location: [[Int]]
}

struct SeedLocation {
    let seed: Int
    let soil: Int
    let fertilizer: Int
    let water: Int
    let light: Int
    let temperature: Int
    let humidity: Int
    let location: Int
}

extension SeedLocation: Identifiable {
    var id: Int { seed }
}
