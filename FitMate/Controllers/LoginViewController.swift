//
//  LoginViewController.swift
//  FitMate
//
//  Created by Ladislav Kroupa on 15.03.2023.
//

import Foundation
import UIKit
import Firebase
import PasswordTextField


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: PasswordTextField!
    @IBOutlet weak var emailValidationLabel: UILabel!
    @IBOutlet weak var pwdValidationLabel: UILabel!
    
    
    let clientManager = FirebaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailTextField.delegate = self
        pwdTextField.delegate = self
        
        
        emailValidationLabel.isHidden = true
        pwdValidationLabel.isHidden = true
        
    }
    
    
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        
        
        
        if let email = emailTextField.text, let password = pwdTextField.text {
            
            clientManager.checkIfIsClientRegistred(email: email) { (isRegistred) in
                
                if (isRegistred) {
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        
                        if let e = error {
                            print(e.localizedDescription)
                            print(e)
                            
                            if e.localizedDescription == "The password is invalid or the user does not have a password." {
                                
                                DispatchQueue.main.async {
                                    self.pwdValidationLabel.isHidden = false
                                    self.pwdValidationLabel.textColor = .systemRed
                                    self.pwdValidationLabel.text = K.Validation.pwdIsNotCorrect
                                }
                                
                            }
                        } else {
                            self.performSegue(withIdentifier: K.goToClientProfile, sender: self)
                        }
                        
                        
                    }
                    
                }
                
            }
        }
        
        
        
    }
}


//MARK: - TextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        if let email = emailTextField.text {
            
            
            if email == "" {
                
                self.emailValidationLabel.isHidden = false
                self.emailValidationLabel.text = K.Validation.emailIsEmpty
                self.emailValidationLabel.textColor = .systemRed
                
                
            } else if email != "" {
                
                clientManager.checkIfIsClientRegistred(email: email) { (isRegistred) in
                    
                    if (isRegistred) {
                        
                        DispatchQueue.main.async {
                            self.emailValidationLabel.isHidden = false
                            self.emailValidationLabel.text = K.Validation.emailsIsValid
                            self.emailValidationLabel.textColor = .systemGreen
                        }
                        
                        
                        
                    } else {
                        DispatchQueue.main.async {
                            self.emailValidationLabel.isHidden = false
                            self.emailValidationLabel.text = K.Validation.emailIsNotRegistered
                            self.emailValidationLabel.textColor = .systemRed
                        }
                        
                    }
                    
                }
            }
            
            
            
        }
        
        
    }
    
    
}


