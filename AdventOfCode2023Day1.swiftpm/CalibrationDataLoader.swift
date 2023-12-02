//
//  CalibrationDataLoader.swift
//  AdventOfCode2023Day1
//
//  Created by Robert Faist on 12/1/23.
//

import Foundation

class CalibrationDataLoader {
    private let fileName = "aoc_input_day1"
    
    func loadCalibrationData() -> [CalibrationDataModel] {
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "txt"),
              let fileContents = try? String(contentsOf: fileUrl) else {
            return []
        }
        
        let lines = fileContents.split(separator: "\n").map({ String($0) })
        
        var calibrationData: [CalibrationDataModel] = []
        
        for line in lines {
            if let firstIndex = line.firstIndex(where: { $0.isNumber }),
               let lastIndex = line.lastIndex(where: { $0.isNumber }),
               let firstDigit = line[firstIndex].wholeNumberValue,
               let lastDigit = line[lastIndex].wholeNumberValue {
                
                let newDataModel =
                    CalibrationDataModel(input: line,
                                         firstDigit: (firstIndex, firstDigit),
                                         lastDigit: (lastIndex, lastDigit))
                
                calibrationData.append(newDataModel)
            }
        }
        
        return calibrationData
    }
}
