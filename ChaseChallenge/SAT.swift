//
//  SAT.swift
//  ChaseChallenge
//
//  Created by Ty Schultz on 10/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit

struct SAT: Codable, Equatable {
    let dbn : String
    let numOfTestTakers : String?
    let criticalReadingAvg : String?
    let mathAvg : String
    let writingAvg : String
    let schoolName : String
    
    enum CodingKeys: String, CodingKey {
        case dbn                = "dbn"
        case numOfTestTakers    = "num_of_sat_test_takers"
        case criticalReadingAvg = "sat_critical_reading_avg_score"
        case mathAvg            = "sat_math_avg_score"
        case writingAvg         = "sat_writing_avg_score"
        case schoolName         = "school_name"
    }
}
