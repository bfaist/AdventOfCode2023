//
//  GameDataLoader.swift
//  AdventOfCode2023Day2
//
//  Created by Robert Faist on 12/2/23.
//

import Foundation

class GameDataLoader {
    private let fileName = "aoc_input_day2"
    
    func loadGameData() -> [GameDataModel] {
        var games: [GameDataModel] = []
        
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "txt"),
              let fileContents = try? String(contentsOf: fileUrl) else {
            return []
        }
        
        let lines = fileContents.split(separator: "\n").map({ String($0) })
        
        for line in lines {
            let gameParts = line.split(separator: ": ")
               
            if let gameId = Int(gameParts[0].split(separator: " ")[1]) {
                let gameSetsPart = gameParts[1]
                
                let gameSets = gameSetsPart.split(separator: "; ")
                
                var diceModels: [GameDiceModel] = []
                
                for gameSet in gameSets {
                    let diceCounts = gameSet.split(separator: ", ")
                    
                    var redCount = 0
                    var blueCount = 0
                    var greenCount = 0
                    
                    for diceCount in diceCounts {
                        if let count = Int(diceCount.split(separator: " ")[0]) {
                           let color = String(diceCount.split(separator: " ")[1])
                            
                            switch color {
                            case DiceColor.red.rawValue: redCount += count
                            case DiceColor.green.rawValue: greenCount += count
                            case DiceColor.blue.rawValue: blueCount += count
                            default:
                                continue
                            }
                        }
                    }
                    
                    let diceCount: [DiceColor: Int] = [
                        .red: redCount,
                        .blue: blueCount,
                        .green: greenCount
                    ]
                    
                    diceModels.append(GameDiceModel(diceCount: diceCount))
                }
                
                games.append(GameDataModel(id: gameId, sets: diceModels))
            }
        }
        
        return games
    }
}
