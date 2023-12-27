//
//  PathDirectionsDataLoader.swift
//  AdventOfCode2023Day8
//
//  Created by Robert Faist on 12/23/23.
//

import Foundation

class PathDirectionsDataLoader {
    private let fileName = "aoc_input_day8"
    
    func loadPathData() async -> PathDataModel? {
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let fileContents = try? Data(contentsOf: fileUrl) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        
        do {
            let jsonData = try decoder.decode(PathDataModel.self, from: fileContents)
            return jsonData
        } catch {
            print("DECODE ERROR: \(error.localizedDescription)")
        }
        
        return nil
    }
}
