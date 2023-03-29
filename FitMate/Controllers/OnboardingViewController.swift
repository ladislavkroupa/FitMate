//
//  OnboardingViewController.swift
//  FitMate
//
//  Created by Ladislav Kroupa on 16.03.2023.
//

import Foundation
import Firebase
import ChameleonFramework
import FirebaseFirestore


class OnboardingViewController: UIViewController {
    
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var nameTXF: UITextField!
    @IBOutlet weak var surnameTXF: UITextField!
    @IBOutlet weak var dateBirthPicker: UIDatePicker!
    
    @IBOutlet weak var phoneNumberTX: UITextField!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightSlider: UISlider!
    
    
    
    var email = String()
    var password = String()
    
    
    var bmi: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        heightLabel.text = "\(String(format: "%.2f", heightSlider.value)) m"
        weightLabel.text = "\(String(format: "%.2f", weightSlider.value)) Kg"
        
        
    }
    
    
    @IBAction func heightChanged(_ sender: UISlider) {
        let height = String(format: "%.2f", sender.value)
        heightLabel.text = "\(height) m"
        
    }
    
    @IBAction func weightChanged(_ sender: UISlider) {
        
        let step: Float = 0.5
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        
        let weight = String(format: "%.1f", sender.value)
        weightLabel.text = "\(weight) Kg"
    }
    
    @IBAction func createBtnPressed(_ sender: UIButton) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            guard let currentUserID = Auth.auth().currentUser?.uid else {
                // Uživatel není přihlášen
                print("User is not sign.")
                return
            }
            
            
            if let e = error {
                print(e.localizedDescription)
            } else {
                if let name = self.nameTXF.text, let surname = self.surnameTXF.text, let phone = self.phoneNumberTX.text {
                    
                    
                    
                    let height = self.heightSlider.value
                    let weight = self.weightSlider.value
                    
                    let newClient = Client()
                    newClient.currentUserID = currentUserID
                    newClient.name = name
                    newClient.surname = surname
                    newClient.email = self.email
                    newClient.phone = phone
                    newClient.dateBirth = self.formatDateBirth(dateBirth: self.dateBirthPicker.date)
                    newClient.dateCreated = Date()
                    newClient.heigh = self.heightSlider.value
                    newClient.weight = self.weightSlider.value
                    newClient.bmi = self.calculateBMI(weight: weight, height: height)
                    
                    
                    //Save to the Firestore
                    self.db.collection(K.FStore.Client.clientCollectionName).addDocument(data: [
                        K.FStore.Client.currentUserID : newClient.currentUserID,
                        K.FStore.Client.clientName : newClient.name,
                        K.FStore.Client.clientSurname : newClient.surname,
                        K.FStore.Client.email : newClient.email,
                        K.FStore.Client.phone : newClient.phone,
                        K.FStore.Client.dateBirth : newClient.dateBirth,
                        K.FStore.Client.weight : newClient.weight,
                        K.FStore.Client.height : newClient.heigh,
                        K.FStore.Client.bmi : newClient.bmi
                        
                        
                    ]){ (error) in
                        if let e = error {
                            print("There was an issue saving data. \(e)")
                        } else {
                            
                            print("succesfully saved data.")
                            self.performSegue(withIdentifier: K.goToClientProfile, sender: self)
                        }
                        
                        
                        
                    }
                    
                    
                } else {
                    
                    print("Error while creating user.")
                }
            }
            
            
        }
        
        
    }
    
    
    func calculateBMI(weight: Float, height: Float) -> Float {
        
        let bmiValue = weight / pow(height, 2)
        bmi = bmiValue
        
        return bmiValue
    }
    
    
    func formatDateBirth(dateBirth: Date) -> String {
        
        let clientDateBirth = dateBirth
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let resultDateBirth = dateFormatter.string(from: clientDateBirth)
        
        return resultDateBirth
        
    }
    
    
    
    
}
