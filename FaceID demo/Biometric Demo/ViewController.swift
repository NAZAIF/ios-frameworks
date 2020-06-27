//
//  ViewController.swift
//  Biometric Demo
//
//  Created by Moideen Nazaif VM on 26/06/20.
//  Copyright © 2020 Moideen Nazaif VM. All rights reserved.
//

import UIKit
import LocalAuthentication

enum LocalAuthenticationError: Error {
    case biometryNotAvailable
    case forwarded(Error)
    case unknown
}

class ViewController: UIViewController {
    
    private func authenticateWithBiometrics(completion: @escaping (Error?) -> Void) {
        let authContext = LAContext()
        var localAuthError: NSError?
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &localAuthError), localAuthError == nil {
            let reason: String
            switch authContext.biometryType {
            case .touchID:
                reason = "Login with Touch ID"
                
            case .faceID:
                reason = "Login with Face ID"
                
            case .none:
                completion(LocalAuthenticationError.biometryNotAvailable)
                return
            }
            
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
                if success {
                    completion(nil)
                } else {
                    if let localError = error {
                        completion(LocalAuthenticationError.forwarded(localError))
                    } else {
                        completion(LocalAuthenticationError.unknown)
                    }
                }
            }
        } else {
            if let error = localAuthError {
                completion(LocalAuthenticationError.forwarded(error))
            } else {
                completion(LocalAuthenticationError.unknown)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authenticateWithBiometrics { (authError) in
            var title = "Success"
            var message = "You logged in successfully with Biometrics"
            
            if let error = authError {
                title = "Failed"
                message = "Could not authenticate using Biometrics. Reason: \(error)"
            }
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(dismissAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
    }
    
    
}

