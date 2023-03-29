//
//  RegisterViewController.swift
//  FitMate
//
//  Created by Ladislav Kroupa on 15.03.2023.
//

import Foundation
import UIKit
import ChameleonFramework
import Firebase
import PasswordTextField

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var validationLabel: UILabel!
    
    @IBOutlet weak var confirmEmailTX: UITextField!
    @IBOutlet weak var emailMatchingLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var pwdValidationLabel: UILabel!
    
    @IBOutlet weak var passwordConfirmationTX: PasswordTextField!
    @IBOutlet weak var pwdConfLabel: UILabel!
    
    let clientManger = FirebaseManager()
    
    var email = String()
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        confirmEmailTX.delegate = self
        
        passwordTextField.delegate = self
        passwordConfirmationTX.delegate = self
        
        
        validationLabel.isHidden = true
        emailMatchingLabel.isHidden = true
        
        pwdValidationLabel.isHidden = true
        pwdConfLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        
        
        if let emailClient = emailTextField.text, let passwordClient = passwordTextField.text, let confirmEmail = confirmEmailTX.text, let confirmPassword = passwordConfirmationTX.text {
            
            
            if ((emailClient == confirmEmail) && (passwordClient == confirmPassword)) && ((emailClient != "") && passwordClient != ""){
                self.validationLabel.isHidden = true
                self.validationLabel.textColor = .systemGreen
                self.email = emailClient
                self.password = passwordClient
                self.performSegue(withIdentifier: K.goToOnBoardingSegue, sender: self)
            }
            
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == K.goToOnBoardingSegue {
            let onBoardingVC = segue.destination as! OnboardingViewController
            onBoardingVC.email = email
            onBoardingVC.password = password
            
        }
        
    }
    
    
    
    
}

//MARK: - TextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        if let emailClient = emailTextField.text, let confirmEmail = confirmEmailTX.text {
            
            
            if emailClient.isEmail() == true {
                
                if emailClient != "" {
                    
                    clientManger.checkIfIsClientRegistred(email: emailClient) { (isRegistered) in
                        
                        if isRegistered {
                            DispatchQueue.main.async {
                                self.validationLabel.isHidden = false
                                self.validationLabel.text = K.Validation.emailIsRegistered
                                self.validationLabel.textColor = .systemRed
                                self.emailMatchingLabel.isHidden = true
                            }
                            
                        } else if (!isRegistered) {
                            
                            if confirmEmail == "" {
                                
                                DispatchQueue.main.async {
                                    self.emailMatchingLabel.isHidden = false
                                    self.emailMatchingLabel.text = K.Validation.emailIsEmpty
                                    self.emailMatchingLabel.textColor = .systemRed
                                }
                                
                                
                            } else if emailClient != confirmEmail {
                                DispatchQueue.main.async {
                                    self.emailMatchingLabel.isHidden = false
                                    self.emailMatchingLabel.text = K.Validation.emailsNotMatching
                                    self.emailMatchingLabel.textColor = .systemRed
                                }
                                
                            } else if emailClient == confirmEmail {
                                DispatchQueue.main.async {
                                    self.emailMatchingLabel.isHidden = false
                                    self.emailMatchingLabel.text = K.Validation.emailsMatching
                                    self.emailMatchingLabel.textColor = .systemGreen
                                }
                                
                                
                            }
                            DispatchQueue.main.async {
                                self.validationLabel.isHidden = false
                                self.validationLabel.text = K.Validation.emailsIsAvalible
                                self.validationLabel.textColor = .systemGreen
                            }
                            
                        }
                    }
                    
                } else {
                    self.validationLabel.isHidden = false
                    self.validationLabel.text = K.Validation.emailIsEmpty
                    self.validationLabel.textColor = .systemRed
                    self.emailMatchingLabel.isHidden = true
                }
                
            } else {
                validationLabel.isHidden = false
                validationLabel.textColor = .systemRed
                validationLabel.text = K.Validation.emailIsNotValid
            }
            
            
            
            
        }
        
        let validationRule = RegexRule(regex:"^.{8,}$", errorMessage: "Password must contains minimum 8 letters.")
        
        passwordTextField.validationRule = validationRule
        
        if let passwordClient = passwordTextField.text, let confirmationPassword = passwordConfirmationTX.text {
            
            if passwordClient == "" {
                pwdValidationLabel.isHidden = false
                pwdValidationLabel.text = K.Validation.pwdIsEmpty
                pwdValidationLabel.textColor = .systemRed
                pwdConfLabel.isHidden = true
            } else if passwordTextField.isInvalid(){
                pwdValidationLabel.isHidden = false
                pwdValidationLabel.text = K.Validation.pwdIsInvalid
                pwdValidationLabel.textColor = .systemRed
            } else if confirmationPassword == "" {
                pwdValidationLabel.isHidden = true
                pwdConfLabel.text = K.Validation.pwdIsEmpty
                pwdConfLabel.textColor = .systemRed
                pwdConfLabel.isHidden = false
            } else if passwordClient != confirmationPassword {
                pwdConfLabel.isHidden = false
                pwdConfLabel.text = K.Validation.pwdIsNotMatching
                pwdConfLabel.textColor = .systemRed
                pwdValidationLabel.isHidden = true

            } else if passwordClient == confirmationPassword {
                pwdValidationLabel.isHidden = true
                pwdConfLabel.text = K.Validation.pwdIsMatching
                pwdConfLabel.textColor = .systemGreen
            }

        }
        
    }
    
    
}





