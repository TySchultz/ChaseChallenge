//
//  School.swift
//  ChaseChallenge
//
//  Created by Ty Schultz on 10/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import Foundation
import IGListKit

struct School: Codable, Equatable {
    //Main info
    let academicopportunities: String?
    let academicopportunitiesSecond: String?
    let attendance_rate: String?
    let borough: String?
    
    let city: String?
    let extracurricular_activities: String?
    let dbn: String
    
    let latitude: String?
    let location: String?
    let longitude: String?
    let neighborhood: String?
    
    let overview_paragraph: String?
    let phone_number: String?
    let primary_address_line_1: String?
    let school_email: String?
    let school_name: String?
    let school_sports: String?
    let state_code: String?
    let subway: String?
    let total_students: String?
    let website: String?
    let zip: String?
}

extension School: Filterable {
    func match(query: String) -> Bool {
        guard   let name = school_name,
                let city = city,
                let borough = borough else { return false }
        
        let lowerQuery = query.lowercased()
        
        if name.lowercased().contains(lowerQuery) { return true }
        if city.lowercased().contains(lowerQuery) { return true }
        if borough.lowercased().contains(lowerQuery) { return true }
        
        return false
    }
}
