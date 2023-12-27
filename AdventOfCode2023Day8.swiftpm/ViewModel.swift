//
//  ViewModel.swift
//  AdventOfCode2023Day8
//
//  Created by Robert Faist on 12/23/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var dataModel: PathDataModel?
    @Published var steps = 0
    @Published var directionIndex = 0
    @Published var currentPath: String = "AAA"
    @Published var followedPaths: [String] = []
    
    private let dataLoader = PathDirectionsDataLoader()
    
    @MainActor
    func loadData() async {
        dataModel = await dataLoader.loadPathData()
    }
    
    @MainActor
    func followPaths() async {
        guard let dataModel = dataModel else { return }
        
        followedPaths.append(currentPath)
        
        while currentPath != "ZZZ" {
            directionIndex = directionIndex < dataModel.directions.count ? directionIndex : 0
            let currentDirection = dataModel.directions[directionIndex]
            
            steps += 1
            directionIndex += 1
            
            if currentDirection == "L",
               let leftPath = dataModel.paths[currentPath]?.left {
                currentPath = leftPath
            } else if currentDirection == "R",
                   let rightPath = dataModel.paths[currentPath]?.right {
                currentPath = rightPath
            } else {
                print("ERROR: Invalid direction \(currentDirection)")
            }
            
            followedPaths.append(currentPath)
            
            print("STEPS : \(steps) \(currentPath)")
        }
    }
}
