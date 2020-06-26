//
//  ViewController.swift
//  Biometric Demo
//
//  Created by Moideen Nazaif VM on 26/06/20.
//  Copyright © 2020 Moideen Nazaif VM. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let authContext = LAContext()
        var localAuthError: NSError?
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &localAuthError), localAuthError == nil {
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Log in with your Touch ID") { (success, error) in
                var title = "Success"
                var message = "You logged in successfully with Biometrics"
                if !success || error != nil {
                    title = "Failed"
                    message = "Could not authenticate using Biometrics. Reason: \(error?.localizedDescription ?? "Unknown")"
                }
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(dismissAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        } else {
            if let error = localAuthError {
                print(error)
            }
        }
    }
    
    
}

