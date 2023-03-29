//
//  ClientProfileViewController.swift
//  FitMate
//
//  Created by Ladislav Kroupa on 15.03.2023.
//

import Foundation
import UIKit
import Firebase
import ChameleonFramework


class ClientProfileViewController: UIViewController {
    
    @IBOutlet weak var nameClientLabel: UILabel!
    @IBOutlet weak var emailClientLabel: UILabel!
    @IBOutlet weak var dateBirthLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    
    
    var currentClient = Client()
    var firebaseManager = FirebaseManager()
    
    var bmi = Float()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseManager.delegate = self
        firebaseManager.loadCurrentClient()
        firebaseManager.loadTrainings()
        
        self.title = "Client Profile"
        
        
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    func checkBMI() {
        
        if bmi < 18.5 {
            bmiLabel.textColor = FlatBlue()
        } else if bmi >= 18.5 && bmi <= 24.9 {
            bmiLabel.textColor = FlatGreen()
        } else if bmi > 24.9 {
            bmiLabel.textColor = FlatRed()
        }
        
    }
    
    
    
    
    
}
//MARK: - ClientManagerDelegate
extension ClientProfileViewController: FirebaseManagerDelegate {
    
    
    func didLoadClientDocID(_ firebaseManager: FirebaseManager, docID: String) {
    }
    
    
    func didLoadTrainings(_ firebaseManager: FirebaseManager, trainingsArray: [Training]) {
    }
    
    
    func didLoadClientDetail(_ firebaseManager: FirebaseManager, client: Client) {
        
        DispatchQueue.main.async {
            
            self.currentClient = client
            self.nameClientLabel.text = "\(client.name) \(client.surname)"
            self.emailClientLabel.text = client.email
            self.phoneNumberLabel.text = client.phone
            self.dateBirthLabel.text = "\(client.dateBirth)"
            self.bmiLabel.text = String(format: "%.2f", client.bmi)
            self.bmi = client.bmi

            self.checkBMI()
            
        }
        
        
    }
    
    func didFailWithError(error: Error) {
        print("Did fail with error: \(error)")
    }
    
    
}
