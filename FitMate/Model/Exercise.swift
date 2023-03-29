//
//  Exercise.swift
//  FitMate
//
//  Created by Ladislav Kroupa on 16.03.2023.
//

import Foundation


class Exercise {
    
    
    var nameExercise: String
    var scoreExercise: Double {
        
        get {
            if let score = sets?[0].getScoreOfSet() {
                return score
            } else {
                return 0.0
            }
        }
        
    }
    var dateCreated: Date = Date()
    var sets: [Sets]?
    
    
    init(nameExercise: String, sets: [Sets]?) {
        self.nameExercise = nameExercise
        self.sets = sets
    }
    
    
}
