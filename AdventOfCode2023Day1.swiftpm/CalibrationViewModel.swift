//
//  CalibrationViewModel.swift
//  AdventOfCode2023Day1
//
//  Created by Robert Faist on 12/1/23.
//

import Foundation

class CalibrationViewModel: ObservableObject {
    @Published var calibrationData: [CalibrationDataModel] = []
    
    private let dataLoader = CalibrationDataLoader()
    
    func loadData() {
        calibrationData = dataLoader.loadCalibrationData()
    }
}
