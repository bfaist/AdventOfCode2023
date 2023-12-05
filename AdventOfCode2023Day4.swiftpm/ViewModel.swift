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
    
    private let dataLoader = CardDataLoader()
    
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
}
