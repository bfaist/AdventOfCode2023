//
//  ViewModel.swift
//  AdventOfCode2023Day6
//
//  Created by Robert Faist on 12/10/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var races: [Race] = []
    @Published var answer: Int = 0
    @Published var computedRaces: [Race] = []
    
    init() {
        // TASK 1
        races = [
            Race(maxTime: 53, recordDistance: 250),
            Race(maxTime: 91, recordDistance: 1330),
            Race(maxTime: 67, recordDistance: 1081),
            Race(maxTime: 68, recordDistance: 1025)
        ]
    }
    
    func findAnswerTask1() {
        for race in races {
            var raceCopy = race
            raceCopy.waysToWin = computeWaysToBeatRecord(race: race)
            computedRaces.append(raceCopy)
        }
        
        answer = computedRaces.reduce(1, { $0 * $1.waysToWin })
    }
    
    func findAnswerTask2() {
        races.removeAll()
        var race = Race(maxTime: 53916768, recordDistance: 250133010811025)
        race.waysToWin = computeWaysToBeatRecord(race: race)
        answer = race.waysToWin
        races.append(race)
    }
    
    func computeWaysToBeatRecord(race: Race) -> Int {
        var waysToWin = 0
        for holdTime in 1..<race.maxTime {
            let speed = holdTime
            let remainingTime = race.maxTime - holdTime
            let distance = speed * remainingTime
            if distance > race.recordDistance {
                waysToWin += 1
            }
        }
        return waysToWin
    }
    
}

struct Race: Identifiable {
    let id = UUID()
    let maxTime: Int
    let recordDistance: Int
    var waysToWin: Int = 0
}
