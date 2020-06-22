//
//  UITextField+Extension.swift
//  Pasteboard
//
//  Created by jerin on 22/06/20.
//  Copyright © 2020 Nyisztor, Karoly. All rights reserved.
//

import UIKit

extension UITextField {
    open override func copy(_ sender: Any?) {
        AppDelegate.customPasteboard?.string = self.text
    }
    
    open override func cut(_ sender: Any?) {
        AppDelegate.customPasteboard?.string = self.text
        self.text = nil
    }
    
    open override func paste(_ sender: Any?) {
        if let text = AppDelegate.customPasteboard?.string {
            self.text = text
        }
    }
}
