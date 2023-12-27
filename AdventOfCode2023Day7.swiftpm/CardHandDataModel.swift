//
//  CardHandDataModel.swift
//  AdventOfCode2023Day7
//
//  Created by Robert Faist on 12/10/23.
//

import Foundation

enum Card: String {
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "T"
    case jack = "J"
    case queen = "Q"
    case king = "K"
    case ace = "A"
}

extension Card {
    var value: Int {
        switch self {
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .five:
            return 5
        case .six:
            return 6
        case .seven:
            return 7
        case .eight:
            return 8
        case .nine:
            return 9
        case .ten:
            return 10
        case .jack:
            return 11
        case .queen:
            return 12
        case .king:
            return 13
        case .ace:
            return 14
        }
    }
    
    var stringCompareValue: String {
        String(format: "%02d", value)
    }
}

enum HandType: Hashable, CaseIterable {
    case FiveOfAKind
    case FourOfAKind
    case FullHouse
    case ThreeOfAKind
    case TwoPair
    case OnePair
    case HighCard
    
    var description: String {
        switch self {
        case .FiveOfAKind:
            return "5 of a kind"
        case .FourOfAKind:
            return "4 of a kind"
        case .FullHouse:
            return "Full House"
        case .ThreeOfAKind:
            return "3 of a kind"
        case .TwoPair:
            return "2 pair"
        case .OnePair:
            return "1 pair"
        case .HighCard:
            return "High Card"
        }
    }
    
    var rankOrder: Int {
        switch self {
        case .FiveOfAKind:
            return 7
        case .FourOfAKind:
            return 6
        case .FullHouse:
            return 5
        case .ThreeOfAKind:
            return 4
        case .TwoPair:
            return 3
        case .OnePair:
            return 2
        case .HighCard:
            return 1
        }
    }
}

extension HandType {
    var cardCountPattern: [Int] {
        switch self {
        case .FiveOfAKind:
            return [5]
        case .FourOfAKind:
            return [4,1]
        case .FullHouse:
            return [3,2]
        case .ThreeOfAKind:
            return [3,1,1]
        case .TwoPair:
            return [2,2,1]
        case .OnePair:
            return [2,1,1,1]
        case .HighCard:
            return [1,1,1,1,1]
        }
    }
}

struct Hand: Hashable {
    let cards: [Card]
    let bid: Int
    var type: HandType?
    var rank: Int?
    
    var handDescription: String {
        cards.map({ $0.rawValue }).joined()
    }
}

extension Array where Element.Type == Hand.Type {
    func sortHands() -> [Hand] {
        self.sorted(by: { h1, h2 in
            let h1cards = h1.cards.map({ $0.stringCompareValue }).joined()
            let h2cards = h2.cards.map({ $0.stringCompareValue }).joined()
            
            if let h1type = h1.type, let h2type = h2.type {
                return h1type.rankOrder > h2type.rankOrder || (h1type.rankOrder == h2type.rankOrder && h1cards > h2cards)
            } else {
                return false
            }
        })
    }
}
