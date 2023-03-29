//
//  TabBarViewController.swift
//  FitMate
//
//  Created by Ladislav Kroupa on 16.03.2023.
//

import UIKit
import Firebase

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var currentClient: Client = Client()
    var firebaseManager = FirebaseManager()
    
    var bmi = Float()
    
    var docID = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseManager.delegate = self
        firebaseManager.loadCurrentClient()
        firebaseManager.loadTrainings()
        
        
        navigationItem.hidesBackButton = true
        self.delegate = self
        self.title = "Client Profile"
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        test()
        
    }
    
    
    func test() {
        
        
        
        if let emailCurrentUser = Auth.auth().currentUser?.email {
            if emailCurrentUser == "n.malyjurkova@gmail.com" || emailCurrentUser == "ladislav.kroupa99@gmail.com" {
                
                
                
            } else {
                print("Else")
                
                // Získání reference na tabBarController a zavolání setNeedsLayout() na tabBar
                
                if var items = self.tabBar.items, items.count > 2 {
                    items[2].isEnabled = false
                    items[2].title = ""
                    items[2].image = nil
                    items.remove(at: 2)
                    tabBar.setNeedsLayout()
                    tabBar.itemPositioning = .fill
                    
                }
                
            }
            
        }
    }
    
    
    
    
    
    
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.navigationItem.title = viewController.title
    }
    
    
    
    
    @IBAction func signOutBtnPressed(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            print("SignOut complete!")
        } catch {
            print("Error while signout: \(error)")
        }
        
    }
    
    
    
    
    func getCurrentUser() -> String {
        let email = Auth.auth().currentUser?.email
        return email!
    }
    
}



extension TabBarViewController: FirebaseManagerDelegate {
    
    
    func didLoadClientDocID(_ firebaseManager: FirebaseManager, docID: String) {
    }
    
    func didLoadTrainings(_ firebaseManager: FirebaseManager, trainingsArray: [Training]) {
        
    }
    
        
    
    func didLoadClientDetail(_ clientManager: FirebaseManager, client: Client) {
        self.currentClient = client
    }
    
    func didFailWithError(error: Error) {
        print("Error while fetching data from ClientManagerDelegate to ClientProfile VC: \(error)")
    }
    
    
}



