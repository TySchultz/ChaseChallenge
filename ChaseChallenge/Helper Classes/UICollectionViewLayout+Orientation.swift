//
//  UICollectionViewLayout+Orientation.swift
//  ChaseChallenge
//
//  Created by Ty Schultz on 10/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit

extension UICollectionViewLayout {

    func invalidateForOrientationChange() {
        // IGListCollectionViewLayout and orientation change dont' play nicely
        // this hack forces the layout to mark itself invalid
        invalidateLayout(with: invalidationContext(forBoundsChange: .zero))
    }

}
