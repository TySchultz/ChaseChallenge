//
//  IGListCollectionViewLayout+Githawk.swift
//  ChaseChallenge
//
//  Created by Ty Schultz on 10/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import Foundation
import IGListKit

extension ListCollectionViewLayout {

    static func basic() -> ListCollectionViewLayout {
        return ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false)
    }

}
