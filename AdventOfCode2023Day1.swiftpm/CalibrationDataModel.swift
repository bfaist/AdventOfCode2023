//
//  CalibrationDataModel.swift
//  AdventOfCode2023Day1
//
//  Created by Robert Faist on 12/1/23.
//

import Foundation

struct CalibrationDataModel: Identifiable {
    let id: UUID = UUID()
    let input: String
    let firstDigit: (String.Index, Int)
    let lastDigit: (String.Index, Int)
}

extension CalibrationDataModel {
    func getCalibrationValue() -> Int {
        return Int("\(firstDigit.1)\(lastDigit.1)") ?? 0
    }
}

extension Array where Element.Type == CalibrationDataModel.Type {
    func getSum() -> Int {
        self.reduce(0, { $0 + $1.getCalibrationValue() })
    }
}

enum TextDigit: String, CaseIterable {
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    
    var substitute: String {
        switch self {
        case .one: return "on1e"
        case .two: return "tw2o"
        case .three: return "thr3ee"
        case .four: return "fo4ur"
        case .five: return "fi5ve"
        case .six: return "si6x"
        case .seven: return "sev7en"
        case .eight: return "eig8ht"
        case .nine: return "ni9ne"
        }
    }
}
