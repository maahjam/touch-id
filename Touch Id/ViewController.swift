//
//  ViewController.swift
//  Touch Id
//
//  Created by mahsajamshidian on 3/3/19.
//  Copyright © 2019 mahsajamshidian. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func touchId(_ sender: Any) {
        
        var authContext = LAContext()
        var authError : NSError?
       
        // check if Touch ID is available

        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "need touch id" , reply: { (success, error) in
                
                if success {
                    
                    DispatchQueue.main.async {
                        
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "mainVC")
                    self.present(vc, animated: true, completion: nil)
                    print("touch id success")
                        
                    }

                }else{
                    
                    print("touch id failed")
                    let alert = UIAlertController(title: "Warning", message: "touch id failed", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert , animated:true , completion:nil)
                    
                }
                
            })
           
           // check if Touch ID is not available
            
        }else{
            
            print("No touch id")
            
            let alertController = UIAlertController (title: "Warning", message: "don't have touch id", preferredStyle: .alert)
            
            // setting Button action
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                
                //guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                guard let settingsUrl = URL(string:"App-Prefs:root=TOUCHID_PASSCODE") else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        
            // Checking for setting is opened or not
                        
                        print("Settings opened: \(success)")
                    })
                }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            
        }
      
    }

}

