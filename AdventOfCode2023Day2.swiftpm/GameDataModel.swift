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
    
    func getMinimumDiceCounts() -> [DiceColor: Int] {
        var maxRedCount = 0
        var maxGreenCount = 0
        var maxBlueCount = 0
        _ = sets.map({
            maxRedCount = $0.diceCount[.red]! > maxRedCount ? $0.diceCount[.red]! : maxRedCount })
        _ = sets.map({
            maxGreenCount = $0.diceCount[.green]! > maxGreenCount ? $0.diceCount[.green]! : maxGreenCount })
        _ = sets.map({
            maxBlueCount = $0.diceCount[.blue]! > maxBlueCount ? $0.diceCount[.blue]! : maxBlueCount })
        return [DiceColor.red: maxRedCount,
                DiceColor.blue: maxBlueCount,
                DiceColor.green: maxGreenCount]
    }
    
    func getDiceMinPower() -> Int {
        let minDiceCounts = self.getMinimumDiceCounts()
        return minDiceCounts[.red]! * minDiceCounts[.green]! * minDiceCounts[.blue]!
    }
}

extension Array where Element.Type == GameDataModel.Type {
    func getSumValidGameIDs() -> Int {
        self.filter({ $0.isGameUnderDiceLimit() }).reduce(0, { $0 + $1.id })
    }
    func getSumOfPowers() -> Int {
        var sumPower = 0
        _ = self.map({ sumPower += $0.getDiceMinPower() })
        return sumPower
    }
}
