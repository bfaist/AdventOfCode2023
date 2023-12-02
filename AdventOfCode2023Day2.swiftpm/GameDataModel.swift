//
//  GameDataModel.swift
//  AdventOfCode2023Day2
//
//  Created by Robert Faist on 12/2/23.
//

import Foundation

struct GameDataModel: Identifiable {
    let id: Int
    let sets: [GameDiceModel]
}

struct GameDiceModel {
    let diceCount: [DiceColor: Int]
}

enum DiceColor: String {
    case red
    case green
    case blue
    
    var maxLimit: Int {
        switch self {
        case .red: return 12
        case .green: return 13
        case .blue: return 14
        }
    }
}

extension GameDataModel {
    func isGameUnderDiceLimit() -> Bool {
        let validSets = sets.filter({
            $0.diceCount[.red] ?? 0 <= DiceColor.red.maxLimit &&
            $0.diceCount[.green] ?? 0 <= DiceColor.green.maxLimit &&
            $0.diceCount[.blue] ?? 0 <= DiceColor.blue.maxLimit
        })
        return validSets.count == sets.count
    }
}

extension Array where Element.Type == GameDataModel.Type {
    func getSumValidGameIDs() -> Int {
        self.filter({ $0.isGameUnderDiceLimit() }).reduce(0, { $0 + $1.id })
    }
}
