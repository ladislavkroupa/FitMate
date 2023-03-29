//
//  ViewController.swift
//  FitMate
//
//  Created by Ladislav Kroupa on 15.03.2023.
//

import UIKit
import CLTypingLabel
import ChameleonFramework

class WelcomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var fitMateLabel: CLTypingLabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registrationBtn: UIButton!
    
    let screenSize = UIScreen.main.bounds.size
    
    let color = UIColor(hexString: "#722f37")!
    
    
    let colors: [UIColor] = [UIColor(hexString: "#722f37")!, UIColor(hexString: "#8b0000")!,  UIColor(hexString: "#a62c3d")!, UIColor(hexString: "#5c1a2d")! ,UIColor(hexString: "#6c2c3e")!,UIColor(hexString: "#8c273a")!, FlatBlack()]
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fitMateLabel.text = K.appName
        fitMateLabel.textColor = FlatWhite()
        fitMateLabel.font = UIFont(name: "DIN Condensed", size: 50)
        fitMateLabel.textAlignment = .center
        
        fitMateLabel.charInterval = 0.00005
        loginBtn.tintColor = FlatWhite()
        registrationBtn.tintColor = FlatWhite()
        
        
        
        //print(dataFilePath)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tabBarItem.isEnabled = false
        
        view.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: CGRect(x: 400, y: 400, width: screenSize.width, height: screenSize.height), colors: colors)
        
        
        
    }
    
    
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        
        print("test login")
    }
    
    
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        
        print("testRegister")
    }
    

}

