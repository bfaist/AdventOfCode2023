//
//  ViewModel.swift
//  AdventOfCode2023Day7
//
//  Created by Robert Faist on 12/10/23.
//

import Foundation

class ViewModel: ObservableObject {
    private let dataLoader = CardHandDataLoader()
    
    @Published var hands: [Hand] = []
    @Published var handsWithType: [Hand] = []
    @Published var sortedHands: [Hand] = []
    @Published var totalWinnings: Int = 0
    
    @MainActor
    func loadData() async {
        hands = await dataLoader.loadCardHards()
        
        for hand in hands {
            let cardMap = Dictionary(grouping: hand.cards, by: { $0.rawValue })
            
            let cardCounts = cardMap.mapValues({ $0.count })
            
            for handType in HandType.allCases {
                if handType.cardCountPattern == Array(cardCounts.values.sorted(by: >)) {
                    var handCopy = hand
                    handCopy.type = handType
                    
                    handsWithType.append(handCopy)
                }
            }
        }
        
        var rank = hands.count
        
        for hand in handsWithType.sortHands() {
            var handCopy = hand
            handCopy.rank = rank
            totalWinnings += (rank * handCopy.bid)
            sortedHands.append(handCopy)
            rank -= 1
        }
    }
}
