//
//  ViewController.swift
//  Pasteboard
//
//  Created by Nyisztor, Karoly on 8/6/18.
//  Copyright © 2018 Nyisztor, Karoly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

//        For security, sensitive information is erased to not see them from recents
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillResignActive, object: nil, queue: OperationQueue.main) { (_) in
            for view in self.view.subviews {
                if let textField = view as? UITextField {
                    textField.text = nil
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


