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
    @Published var gearRatioSum: Int = 0

    private let dataLoader = EngineSchematicDataLoader()
    
    func loadDataTask1() async {
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
    
    func loadDataTask2() async {
        let items = await dataLoader.loadEngineSchematic()
        
        let partNumbers = items.getAllPartNumbers()
        let symbols = items.getAllSymbols()
        
        var gearRatiosToSum: [Int] = []
        
        let maybeGearSymbols = symbols.filter({ $0.type.value == "*" })
        
        for symbol in maybeGearSymbols {
            let partNumbersBeforeSymbol = partNumbers.filter({ $0.row == symbol.row && $0.endCol == symbol.startCol - 1 })
            let partNumbersAfterSymbol = partNumbers.filter({ $0.row == symbol.row && $0.startCol == symbol.endCol + 1})
            let partNumbersRowAfterSymbol = partNumbers.filter({ $0.row == symbol.row + 1 && $0.endCol >= symbol.startCol - 1 && $0.startCol <= symbol.endCol + 1 })
            let partNumbersRowBeforeSymbol = partNumbers.filter({ $0.row == symbol.row - 1 && $0.endCol >= symbol.startCol - 1 && $0.startCol <= symbol.endCol + 1 })
            
            if (partNumbersBeforeSymbol.count + partNumbersAfterSymbol.count + partNumbersRowBeforeSymbol.count + partNumbersRowAfterSymbol.count) == 2 {
                var partToCalcGearRatio: [SchematicDataModel] = []
                
                if partNumbersBeforeSymbol.count > 0 {
                    for partNumber in partNumbersBeforeSymbol {
                        partToCalcGearRatio.append(partNumber)
                    }
                }
                if partNumbersAfterSymbol.count > 0 {
                    for partNumber in partNumbersAfterSymbol {
                        partToCalcGearRatio.append(partNumber)
                    }
                }
                if partNumbersRowBeforeSymbol.count > 0 {
                    for partNumber in partNumbersRowBeforeSymbol {
                        partToCalcGearRatio.append(partNumber)
                    }
                }
                if partNumbersRowAfterSymbol.count > 0 {
                    for partNumber in partNumbersRowAfterSymbol {
                        partToCalcGearRatio.append(partNumber)
                    }
                }
                
                if partToCalcGearRatio.count == 2 {
                    let gearRatio = Int(partToCalcGearRatio[0].type.value)! * Int(partToCalcGearRatio[1].type.value)!
                    
                    gearRatiosToSum.append(gearRatio)
                }
            }
        }
        
        self.gearRatioSum = gearRatiosToSum.reduce(0, { $0 + $1 })
    }
}
