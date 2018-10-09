//
//  SchoolViewModel.swift
//  ChaseChallenge
//
//  Created by Ty Schultz on 10/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import StyledTextKit

final class SchoolViewModel: ListDiffable {
    
    let school: School
    let borough: String
    let name: String
    let location: String
    let phone: String
    
    let cellHeight : CGFloat

    private let _diffIdentifier: NSObjectProtocol
    
    init(school: School, width : CGFloat) {
        self.school = school

        self.borough  = school.borough ?? "No Borough"
        self.name     = school.school_name ?? "Blank"
        self.phone    = school.phone_number ?? "No Phone Number"

        //Location includes longitude and latitude, strip them out
        if let location = school.location,
            let prettyLocation = location.split(separator: "(").first {
            self.location = String(prettyLocation)
        }else {
            self.location = "No Location"
        }
        
        //Calculate height for self sizing cell
        let textWidth = width - SchoolCell.titleInset.left*2
        let boroughHeight  = self.borough.height(withWidth: textWidth, font: Styles.Text.borough.font(contentSizeCategory: .preferred))
        let nameHeight     = self.name.height(withWidth: textWidth, font: Styles.Text.name.font(contentSizeCategory: .preferred))
        let locationHeight = self.location.height(withWidth: textWidth, font: Styles.Text.location.font(contentSizeCategory: .preferred))
        let phoneHeight    = self.phone.height(withWidth: textWidth, font: Styles.Text.phone.font(contentSizeCategory: .preferred))
        
        cellHeight = boroughHeight + nameHeight + locationHeight + phoneHeight + SchoolCell.titleInset.top*7
        
        _diffIdentifier = school.dbn as NSObjectProtocol
    }

    // MARK: ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return _diffIdentifier
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }
    
}
