//
//  ViewModel.swift
//  AdventOfCode2023Day3
//
//  Created by Robert Faist on 12/3/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var schematicItems: [SchematicDataModel] = []
    @Published var partNumberSum: Int = 0

    private let dataLoader = EngineSchematicDataLoader()
    
    func loadData() async {
        let items = await dataLoader.loadEngineSchematic()

        var partNumbersToSum: [SchematicDataModel] = []
        
        let partNumbers = items.getAllPartNumbers()
        let symbols = items.getAllSymbols()
        
        for partNumber in partNumbers {
            let symbolBeforePartNumber = symbols.filter({ $0.row == partNumber.row && $0.startCol == partNumber.startCol - 1})
            
            if symbolBeforePartNumber.count > 0 {
                print("SYMBOL BEFORE \(partNumber.type.value)")
                partNumbersToSum.append(partNumber)
                continue
            }
            
            let symbolAfterPartNumber = symbols.filter({ $0.row == partNumber.row && $0.startCol == partNumber.endCol + 1})
            
            if symbolAfterPartNumber.count > 0 {
                print("SYMBOL AFTER \(partNumber.type.value)")
                partNumbersToSum.append(partNumber)
                continue
            }
            
            let symbolsNextRow = symbols.filter({ $0.row == partNumber.row + 1 &&
                $0.startCol >= partNumber.startCol - 1 &&
                $0.endCol <= partNumber.endCol + 1
            })
            
            if symbolsNextRow.count > 0 {
                print("SYMBOL NEXT ROW \(partNumber.type.value)")
                partNumbersToSum.append(partNumber)
                continue
            }
            
            if partNumber.row == 0 {
                print("INVALID PART \(partNumber.type.value)")
                continue
            }
            
            let symbolsPrevRow = symbols.filter({ $0.row == partNumber.row - 1 &&
                $0.startCol >= partNumber.startCol - 1 &&
                $0.endCol <= partNumber.endCol + 1
            })
            
            if symbolsPrevRow.count > 0 {
                print("SYMBOL PREV ROW \(partNumber.type.value)")
                partNumbersToSum.append(partNumber)
                continue
            }
            
            print("INVALID PART \(partNumber.type.value)")
        }
        
        let sum = partNumbersToSum.sumPartNumbers()
        
        DispatchQueue.main.async {
            self.schematicItems = items
            self.partNumberSum = sum
        }
    }
}
