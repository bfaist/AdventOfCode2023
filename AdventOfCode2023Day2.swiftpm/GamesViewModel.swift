//
//  GamesViewModel.swift
//  AdventOfCode2023Day2
//
//  Created by Robert Faist on 12/2/23.
//

import Foundation

class GamesViewModel: ObservableObject {
    @Published var games: [GameDataModel] = []
    
    private let dataLoader = GameDataLoader()
    
    func loadData() {
        games = dataLoader.loadGameData()
    }
}
