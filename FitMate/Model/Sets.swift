//
//  Set.swift
//  FitMate
//
//  Created by Ladislav Kroupa on 16.03.2023.
//

import Foundation



class Sets {
    
    var setWeight: Double
    var setReps: Double
    var dateCreated: Date = Date()
    
    var setScore: Double {
        get {
            return setWeight * setReps
        }
    }
    
    
    func getScoreOfSet() -> Double {
        return setScore
    }
    
    
    init(setWeight: Double, setReps: Double) {
        self.setWeight = setWeight
        self.setReps = setReps
    }
    
}
