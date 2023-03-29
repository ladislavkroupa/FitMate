//
//  ClientManager.swift
//  FitMate
//
//  Created by Ladislav Kroupa on 16.03.2023.
//

import Foundation
import Firebase
import FirebaseFirestore


protocol FirebaseManagerDelegate {
    
    func didLoadClientDetail(_ firebaseManager: FirebaseManager, client: Client)
    func didFailWithError(error: Error)
    func didLoadTrainings(_ firebaseManager: FirebaseManager, trainingsArray: [Training])
    func didLoadClientDocID(_ firebaseManager: FirebaseManager, docID: String)
}


class FirebaseManager {
    
    let db = Firestore.firestore()
    
    
    var delegate: FirebaseManagerDelegate?
    var trainingsArray: [Training] = []
    
    
    
    func loadCurrentClient() {
        
        
        
        if let userID = Auth.auth().currentUser?.uid {
            
            db.collection(K.FStore.Client.clientCollectionName)
                .addSnapshotListener { (querySnapshot, error) in
                    
                    
                    if let e = error {
                        print("Error getting documents: \(e)")
                    } else {
                        if let snapshotDocuments = querySnapshot?.documents {
                            for doc in snapshotDocuments {
                                let data = doc.data()
                                
                                
                                if userID == data[K.FStore.Client.currentUserID] as! String {
                                    
                                    
                                    let newClient = Client()
                                    if let timestamp = data[K.FStore.Client.dateCreated] as? TimeInterval {
                                        newClient.dateCreated = Date(timeIntervalSince1970: timestamp)
                                    }
                                    newClient.dateBirth = data[K.FStore.Client.dateBirth] as? String ?? ""
                                    newClient.name = data[K.FStore.Client.clientName] as? String ?? ""
                                    newClient.surname = data[K.FStore.Client.clientSurname] as? String ?? ""
                                    newClient.email = data[K.FStore.Client.email] as? String ?? ""
                                    newClient.phone = data[K.FStore.Client.phone] as? String ?? ""
                                    newClient.weight = data[K.FStore.Client.weight] as? Float ?? 0.0
                                    newClient.heigh = data[K.FStore.Client.height] as? Float ?? 0.0
                                    newClient.bmi = data[K.FStore.Client.bmi] as? Float ?? 0.0
                                    self.delegate?.didLoadClientDetail(self, client: newClient)
                                    
                                }
                                
                                
                                
                            }
                        }
                    }
                    
                }
            
        }
        
        
        
    }
    
    
    func checkIfIsClientRegistred(email: String, completition: @escaping (Bool) -> Void) {
        
        Auth.auth().fetchSignInMethods(forEmail: email) { (providers, error) in
            
            if let e = error {
                print("Error checking email in Firebase: \(e.localizedDescription)")
                completition(false)
                return
                
            }
            if let providers = providers, providers.count > 0 {
                completition(true)
            } else {
                completition(false)
            }
            
        }
        
        
    }
    
    
    func getCurrentClientEmail() -> String {
        
        let email = Auth.auth().currentUser?.email!
        
        return email!
        
    }
    
    
    
    
    func loadTrainings() {
        
        
        if let currentUserID = Auth.auth().currentUser?.uid {
            
            db.collection(K.FStore.Client.clientCollectionName)
                .addSnapshotListener { (querySnapshots, error) in
                    
                    if let e = error {
                        print("Error while getting documents: \(e)")
                    } else {
                        
                        
                        if let documentsSnapshots = querySnapshots?.documents {
                            
                            
                            for doc in documentsSnapshots{
                                
                                let data = doc.data()
                                
                                if currentUserID == data[K.FStore.Client.currentUserID] as! String {
                                    
                                    
                                    let docID = doc.documentID
                                    self.delegate?.didLoadClientDocID(self, docID: docID)
                                    
                                    let clientRef = Firestore.firestore().collection(K.FStore.Client.clientCollectionName).document(docID)
                                    let trainingsRef = clientRef.collection(K.FStore.Training.trainingCollectionName)
                                    
                                    trainingsRef.order(by: K.FStore.Training.dateCreated, descending: true).getDocuments() { (querySnapshot, error) in
                                        if let error = error {
                                            print("Error fetching trainings: \(error.localizedDescription)")
                                            return
                                        }
                                        
                                        guard let documents = querySnapshot?.documents else {
                                            print("No trainings found")
                                            return
                                        }
                                        
                                        for document in documents {
                                            
                                            let data = document.data()
                                            let trainingName = data[K.FStore.Training.trainingName] as? String ?? ""
                                            
                                            
                                            let trainingDate = data[K.FStore.Training.trainingDate] as? Timestamp ?? Timestamp()
                                            let dateCreated = data[K.FStore.Training.dateCreated] as? Timestamp ?? Timestamp()
                                            
                                            let newTraining = Training(trainingDate: trainingDate.dateValue(), trainingName: trainingName, dateCreated: dateCreated.dateValue())
                                            self.trainingsArray.append(newTraining)
                                            self.delegate?.didLoadTrainings(self, trainingsArray: self.trainingsArray)
                                            
                                        }
                                    }
                                    
                                    
                                    
                                }
                            }
                            
                        }
                        
                    }
                    
                    
                }
            
        }
    }
    
    
}
