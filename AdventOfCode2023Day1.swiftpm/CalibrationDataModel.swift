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
