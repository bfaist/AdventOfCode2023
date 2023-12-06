//
//  ViewModel.swift
//  AdventOfCode2023Day4
//
//  Created by Robert Faist on 12/4/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var cardTotalScore: Int = 0
    @Published var cardsWithScores: [CardDataModel] = []
    @Published var cardCountSum: Int = 0
    @Published var cardIdCountMap: [Int:Int] = [:]
    
    private let dataLoader = CardDataLoader()
    
    @MainActor
    func loadDataTask1() async {
        let cards = await dataLoader.loadCards()
        
        for card in cards {
            var cardCopy = card
            let haveWinningMatches = card.haveNumbers.filter({ card.winningNumbers.contains($0) })
            
            let cardScore = haveWinningMatches.count == 0 ? 0 : pow(2, haveWinningMatches.count - 1)
            
            cardCopy.haveWinningMatch = haveWinningMatches
            cardCopy.score = (cardScore as NSDecimalNumber).intValue
            
            cardsWithScores.append(cardCopy)
        }
        
        cardTotalScore = cardsWithScores.reduce(0, { $0 + $1.score! })
    }
    
    @MainActor
    func loadDataTask2() async {
        let cards = await dataLoader.loadCards()
        
        // set initial count
        for card in cards {
            cardIdCountMap[card.id] = 1
        }
        
        for card in cards {
            let matchCount = card.haveNumbers.filter({ card.winningNumbers.contains($0) }).count
            
            print("CARD \(card.id) \(matchCount)")
            
            if matchCount == 0 {
                continue
            }
            
            print("RANGE: \((card.id+1)...(card.id+matchCount))")
            
            for cardIdRange in (card.id+1)...(card.id+matchCount) {
                if let _ = cardIdCountMap[cardIdRange] {
                    cardIdCountMap[cardIdRange]! += 1
                }
            }
            
            if let cardCount = cardIdCountMap[card.id], cardCount > 1 {
                for _ in 0..<(cardCount-1) {
                    for cardIdRange in (card.id+1)...(card.id+matchCount) {
                        if let _ = cardIdCountMap[cardIdRange] {
                            cardIdCountMap[cardIdRange]! += 1
                        }
                    }
                }
            }
        }
        
        cardIdCountMap.keys.forEach({ cardCountSum += cardIdCountMap[$0] ?? 0 })
        
        print(cardIdCountMap)
    }
}
