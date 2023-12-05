//
//  CardDataLoader.swift
//  AdventOfCode2023Day4
//
//  Created by Robert Faist on 12/4/23.
//

import Foundation
import RegexBuilder

class CardDataLoader {
    private let fileName = "aoc_input_day4"
    
    func loadCards() async -> [CardDataModel] {
        var cards: [CardDataModel] = []
        
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "txt"),
              let fileContents = try? String(contentsOf: fileUrl) else {
            return []
        }
        
        let lines = fileContents.split(separator: "\n").map({ String($0) })
        
        for line in lines {
            let lineParts = line.split(separator: ":")
            
            let cardNumberPart = String(lineParts[0])
            let cardDataPart = String(lineParts[1])
            
            let cardNumber = cardNumberPart
                                .replacingOccurrences(of: "Card", with: "")
                                .replacingOccurrences(of: " ", with: "")
            
            let cardDataParts = cardDataPart.split(separator: " | ")
            
            var winningPart = String(cardDataParts[0])
            var havePart = String(cardDataParts[1])
            
            winningPart = winningPart.replacingOccurrences(of: "  ", with: " ")
            havePart = havePart.replacingOccurrences(of: "  ", with: " ")
            
            let winningNumbers = winningPart.split(separator: " ").map { Int($0)! }
            let haveNumbers = havePart.split(separator: " ").map { Int($0)! }
            
            if let cardId = Int(cardNumber) {
                let model = CardDataModel(id: cardId,
                                          winningNumbers: winningNumbers,
                                          haveNumbers: haveNumbers)
                cards.append(model)
            }
        }
     
        return cards
    }
}
