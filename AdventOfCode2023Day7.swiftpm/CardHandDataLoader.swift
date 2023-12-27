//
//  CardHandDataLoader.swift
//  AdventOfCode2023Day7
//
//  Created by Robert Faist on 12/10/23.
//

import Foundation

class CardHandDataLoader {
    private let fileName = "aoc_input_day7"
    
    func loadCardHards() async -> [Hand] {
        var hands: [Hand] = []
        
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "txt"),
              let fileContents = try? String(contentsOf: fileUrl) else {
            return []
        }
        
        let lines = fileContents.split(separator: "\n").map({ String($0) })
        
        for line in lines {
            let lineParts = line.split(separator: " ")
            
            var cards: [Card] = []
            
            if let handData = lineParts.first {
                cards = handData.split(separator: "").map({ Card(rawValue: String($0))! })
            }
            
            let bid = Int(lineParts[1]) ?? 0
            
            if !cards.isEmpty && bid > 0 {
                let hand = Hand(cards: cards, bid: bid)
                hands.append(hand)
            }
        }
        
        return hands
    }
}
