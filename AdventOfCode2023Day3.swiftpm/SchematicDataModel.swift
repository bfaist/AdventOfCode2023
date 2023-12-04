//
//  PartNumberDataModel.swift
//  AdventOfCode2023Day3
//
//  Created by Robert Faist on 12/3/23.
//

import Foundation

enum DiagramType: Equatable {
    case partNumber(value: Int)
    case symbol(value: String)
    
    static func ==(rhs: DiagramType, lhs: DiagramType) -> Bool {
        switch (rhs, lhs) {
        case (.partNumber, .partNumber):
            return true
        case (.symbol, .symbol):
            return true
        default:
            return false
        }
    }
    
    var value: String {
        switch self {
        case .partNumber(let value):
            return String(value)
        
        case .symbol(let value):
            return value
        }
    }
}

struct SchematicDataModel: Identifiable {
    let id: UUID = UUID()
    let type: DiagramType
    let row: Int
    let startCol: Int
    let endCol: Int
}

extension Array where Element.Type == SchematicDataModel.Type {
    func getAllPartNumbers() -> [SchematicDataModel] {
        self.filter({ $0.type == .partNumber(value: 0) })
    }
    func getAllSymbols() -> [SchematicDataModel] {
        self.filter({ $0.type == .symbol(value: "") })
    }
    func sumPartNumbers() -> Int {
        self.getAllPartNumbers().reduce(0, {
            switch $1.type {
            case .partNumber(let value):
                return $0 + value
            default:
                return 0
            }
        })
    }
}
