//
//  Constants.swift
//  FitMate
//
//  Created by Ladislav Kroupa on 15.03.2023.
//

import Foundation


struct K {
    
    
    static let appName = "FITMATE"
    
    //Segue
    static let goToClientProfile = "goToClientProfile"
    static let goToOnBoardingSegue = "goToOnboarding"
    static let goToWorkouts = "goToWorkout"
    static let goToAdminPanel = "goToAdminPanel"
    
    
    static let cellSwipeIdentifier = "cell"
    
    struct Validation {
        //Validation
        static let emailIsRegistered = "This e-mail address is already registered"
        static let emailsIsAvalible = "This e-mail address is avalible"
        static let emailsNotMatching = "E-mail does not match"
        static let emailsMatching = "E-mail is correct"
        static let emailIsEmpty = "Enter your email"
        static let emailBadFormmating = "The email address is badly formatted"
        static let pwdIsNotMatching = "Password does not match"
        static let pwdIsMatching = "Password is correct"
        static let pwdIsEmpty = "Enter your password"
        static let pwdIsInvalid = "Password must contain minimum 8 letters."
        static let emailIsNotRegistered = "Email is not registered."
        static let emailsIsValid = "Email is valid"
        static let pwdIsNotCorrect = "Wrong password"
        static let emailIsNotValid = "Email has bad formatting."
    }
    
    struct FStore {
        
        struct Client {
            static let currentUserID = "currentUserID"
            static let dateCreated = "dateCreated"
            static let clientCollectionName = "clients"
            static let clientName = "name"
            static let clientSurname = "surname"
            static let email = "email"
            static let phone = "phone"
            static let dateBirth = "dateBirth"
            static let weight = "weight"
            static let height = "height"
            static let bmi = "bmi"
            static let trainings = "trainings"
            
            struct Training {
                static let currentUserID = "currentUserID"
                static let trainingCollectionName = "trainings"
                static let trainingDate = "trainingDate"
                static var trainingName = "trainingName"
                static let dateCreated = "dateCreated"
                static let workouts = "workouts"
                
            }
            
        }
        
        struct Training {
            static let currentUserID = "currentUserID"
            static let trainingCollectionName = "trainings"
            static let trainingDate = "trainingDate"
            static var trainingName = "trainingName"
            static let dateCreated = "dateCreated"
            static let workouts = "workouts"
            
        }
        
        struct Workout {
            static let currentUserID = "currentUserID"
            static let workoutCollectionName = "workouts"
            static let nameExercise = "nameExercise"
            static let scoreExercise = "scoreExercise"
            static let dateCreated = "dateCreated"
            static let sets = "sets"
        }
        
        struct Sets {
            static let currentUserID = "currentUserID"
            static let setCollectionName = "sets"
            static let setWeight = "setWeight"
            static let setReps = "setReps"
            static let setScore = "setScore"
            static let dateCreated = "dateCreated"
        }
        
        
        
        
    }
    
    
    
}
