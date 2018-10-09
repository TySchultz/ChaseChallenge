//
//  Networking.swift
//  ChaseChallenge
//
//  Created by Ty Schultz on 10/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import Alamofire
class Networking: NSObject {

    func download(url : URL, completionHandler: @escaping (Data?, Error?) -> ()) {
//        let url = "https://data.cityofnewyork.us/resource/97mf-9njv.json"
        Alamofire.request(url, encoding: JSONEncoding.default)
            .responseJSON { response in
                completionHandler(response.data, response.error)
        }
    }
}
