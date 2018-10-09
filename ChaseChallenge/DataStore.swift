//
//  DataStore.swift
//  ChaseChallenge
//
//  Created by Ty Schultz on 10/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit


protocol dataStoreDelegate {
    func didDownloadSchools(schools: [School])
    func didDownloadScores(scores: [SAT])
    func errorDownloadingData(error: Error?)
}
class DataStore: NSObject {
    
    let SCHOOLJSON = "https://data.cityofnewyork.us/resource/97mf-9njv.json"
    let SATJSON    = "https://data.cityofnewyork.us/resource/734v-jeq5.json"
    
    var delegate : dataStoreDelegate?
    
    init(delegate: dataStoreDelegate) {
        self.delegate = delegate
    }
    
    func downloadSchools() {
        guard let del = delegate else { fatalError() }
        guard let url = URL(string: SCHOOLJSON) else { fatalError() }
        Networking().download(url: url) { (data, error) in
            do {
                //Handle Error
                self.handleError(error: error)

                guard let data = data else { fatalError() }
                
                let schools = try JSONDecoder().decode([School].self, from: data)
                let sortedSchools = schools.sorted(by: { (left, right) -> Bool in
                    let leftName  = left.school_name ?? "No Name"
                    let rightName = right.school_name ?? "No Name"
                    return leftName < rightName
                })
                
                del.didDownloadSchools(schools: sortedSchools)
            } catch let jsonError {
                self.handleError(error: jsonError)
            }
        }
    }
    
    func downloadScores() {
        guard let del = delegate else { fatalError() }
        guard let url = URL(string: SATJSON) else { fatalError() }
        Networking().download(url: url) { (data, error) in
            do {
                //Handle Error
                self.handleError(error: error)
                
                guard let data = data else { fatalError() }
                
                let scores = try JSONDecoder().decode([SAT].self, from: data)
                del.didDownloadScores(scores: scores)
            } catch let jsonError {
                self.handleError(error: jsonError)

            }
        }
    }
    
    func handleError(error: Error?) {
        guard let del = self.delegate else { fatalError() }
        
        //Handle Error
        guard error == nil else {
            del.errorDownloadingData(error: error)
            return
        }
    }
}
