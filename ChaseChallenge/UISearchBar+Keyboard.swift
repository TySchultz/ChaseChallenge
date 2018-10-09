//
//  UISearchBar+Keyboard.swift
//  ChaseChallenge
//
//  Created by Ty Schultz on 10/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//


import UIKit

extension UISearchBar {

    // MARK: Public API

    func resignWhenKeyboardHides() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(resignFirstResponder),
            name: .UIKeyboardWillHide,
            object: nil
        )
    }

}
