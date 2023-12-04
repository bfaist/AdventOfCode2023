//
//  PartNumberDataLoader.swift
//  AdventOfCode2023Day3
//
//  Created by Robert Faist on 12/3/23.
//

import Foundation

class EngineSchematicDataLoader {
    private let fileName = "aoc_input_day3"
    
    func loadEngineSchematic() async -> [SchematicDataModel] {
        var schematicItems: [SchematicDataModel] = []
        
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "txt"),
              let fileContents = try? String(contentsOf: fileUrl) else {
            return []
        }
        
        let lines = fileContents.split(separator: "\n").map({ String($0) })
        
        for (row, line) in lines.enumerated() {
            var partNumString = ""
            var startCol = 0
            var endCol = 0

            for (col, char) in line.enumerated() {
                if !char.isNumber, char != "." {
                    let symbolModel = SchematicDataModel(type: .symbol(value: String(char)),
                                                         row: row,
                                                         startCol: col,
                                                         endCol: col)
                    schematicItems.append(symbolModel)
                    
                    if partNumString.count > 0 {
                        endCol = col - 1
                        
                        if let partNum = Int(partNumString) {
                            let newPartNumberModel = SchematicDataModel(type: .partNumber(value: partNum),
                                                                         row: row,
                                                                         startCol: startCol,
                                                                         endCol: endCol)
                            schematicItems.append(newPartNumberModel)
                            partNumString = ""
                        }
                    }
                } else if char.isNumber {
                    if partNumString.count == 0 {
                        startCol = col
                    }
                        
                    partNumString.append(char)
                    continue
                }
                
                if partNumString.count > 0 {
                    endCol = col - 1
                    
                    if let partNum = Int(partNumString) {
                        let newPartNumberModel = SchematicDataModel(type: .partNumber(value: partNum),
                                                                     row: row,
                                                                     startCol: startCol,
                                                                     endCol: endCol)
                        schematicItems.append(newPartNumberModel)
                        partNumString = ""
                    }
                }
            }
            
            if partNumString.count > 0 {
                endCol = line.count - 1
                
                if let partNum = Int(partNumString) {
                    let newPartNumberModel = SchematicDataModel(type: .partNumber(value: partNum),
                                                                 row: row,
                                                                 startCol: startCol,
                                                                 endCol: endCol)
                    schematicItems.append(newPartNumberModel)
                    partNumString = ""
                }
            }
        }
        
        return schematicItems
    }
}
