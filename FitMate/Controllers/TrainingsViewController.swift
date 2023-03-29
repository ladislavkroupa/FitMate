//
//  ExerciseViewController.swift
//  FitMate
//
//  Created by Ladislav Kroupa on 16.03.2023.
//

import UIKit
import SwipeCellKit
import FirebaseFirestore
import Firebase

class TrainingsViewController: SwipeTableViewController {
    
    
    var trainingsArray: [Training]? = []
    
    let db = Firestore.firestore()
    
    var currentClient = Client()
    
    var docID = String()
    
    
    let firebaseManager = FirebaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseManager.delegate = self
        firebaseManager.loadCurrentClient()
        firebaseManager.loadTrainings()
        
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.title = "Training"
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return trainingsArray?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let training = trainingsArray?[indexPath.row] {
            
            
            cell.textLabel?.text = training.trainingName
            
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: K.goToWorkouts, sender: self)
        
    }
    
    
    
    
    @IBAction func addTrainPressed(_ sender: UIButton) {
        
        print("btn: \(self.docID)")
        
        var textFieldName = UITextField()
        let alert = UIAlertController(title: "Add New Training", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add new Training", style: .default) { (action) in
            
            if textFieldName.text == nil || textFieldName.text == ""{
                print("Empty value!")
            } else {
                
                if let newTrainingName = textFieldName.text {
                   
                    if let userID = Auth.auth().currentUser?.uid {
                        
                        let newTraining = Training(trainingDate: Date(), trainingName: newTrainingName, dateCreated: Date())
                        
                        
                        let clientRef = Firestore.firestore().collection(K.FStore.Client.clientCollectionName).document(self.docID)
                        
                        let trainingsRef = clientRef.collection(K.FStore.Training.trainingCollectionName)
                        
                        trainingsRef.addDocument(data: [
                            K.FStore.Client.Training.trainingName : newTraining.trainingName,
                            K.FStore.Client.Training.currentUserID : userID,
                            K.FStore.Client.Training.trainingDate : newTraining.trainingDate,
                            K.FStore.Client.Training.dateCreated : newTraining.dateCreated
                        
                        ]) { (error) in
                            if let e = error {
                                print("There was an issue saving data. \(e)")
                            } else {
                                print("Succesfully saved data.")
                            }
                        }
                        self.trainingsArray?.append(newTraining)
                        
                    }
                    
                    self.tableView.reloadData()
                }
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) {_ in
            self.dismiss(animated: true)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new Trainig"
            textFieldName = alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        present(alert, animated: true,completion: nil)
        
        
        
        
    }
    
    
    
}

//MARK: - ClientManagerDelegate
extension TrainingsViewController: FirebaseManagerDelegate {
    func didLoadClientDocID(_ firebaseManager: FirebaseManager, docID: String) {
        
        DispatchQueue.main.async {
            self.docID = docID
        }
        
    }
    
    func didLoadClientDetail(_ clientManager: FirebaseManager, client: Client) {
        
        DispatchQueue.main.async {
            self.currentClient = client
        }
        
    }
    
    func didFailWithError(error: Error) {
        print("Did fail with error: \(error)")
    }
    
    
    func didLoadTrainings(_ firebaseManager: FirebaseManager, trainingsArray: [Training]) {
        
        DispatchQueue.main.async {
            self.trainingsArray = trainingsArray
            self.tableView.reloadData()
        }
           
    }
    
    
    
}

