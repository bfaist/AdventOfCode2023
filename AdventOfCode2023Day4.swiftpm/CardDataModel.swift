//
//  CardDataModel.swift
//  AdventOfCode2023Day4
//
//  Created by Robert Faist on 12/4/23.
//

import Foundation

struct CardDataModel: Identifiable {
    let id: Int
    let winningNumbers: [Int]
    let haveNumbers: [Int]
    var score: Int?
    var haveWinningMatch: [Int]?
}
