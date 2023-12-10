//
//  SeedDataLoader.swift
//  AdventOfCode2023Day5
//
//  Created by Robert Faist on 12/5/23.
//

import Foundation

class SeedDataLoader {
    private let fileName = "aoc_input_day5"
    
    func loadSeedData() -> SeedDataModel? {
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let fileContents = try? Data(contentsOf: fileUrl) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        
        do {
            let jsonData = try decoder.decode(SeedDataModel.self, from: fileContents)
            return jsonData
        } catch {
            print("DECODE ERROR: \(error.localizedDescription)")
        }
        
        return nil
    }
}
