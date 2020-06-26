//
//  ViewController.swift
//  Data Protection Demo
//
//  Created by Moideen Nazaif VM on 26/06/20.
//  Copyright © 2020 Moideen Nazaif VM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private func secureSave(text: String, to fileURL: URL) -> Bool {
        guard let data = text.data(using: .utf8) else {
            return false
        }
        do {
            try data.write(to: fileURL, options: [.completeFileProtectionUnlessOpen])
        } catch {
            print(error)
            return false
        }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let text = "Super secret text"
        if let fileURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("protectedData.txt") {
            let result = secureSave(text: text, to: fileURL)
            let message = result ? "Save completed" : "Save failed"
            print(message)
        }
    }


}

