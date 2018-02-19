//
//  Networking.swift
//  ScoreCenter
//
//  Created by Ruhl, Glen (ELS-PHI) on 2/18/18.
//  Copyright © 2018 Ruhl, Glen (ELS-PHI). All rights reserved.
//

import Foundation

class Networking {
    
    class func getTodaysNbaData(completion: (((Bool) -> Void)?)) {
        guard let todaysNbaUrl = URL(string: "http://data.nba.net/10s/prod/v1/20170218/scoreboard.json") else {
            print("error creating 'todaysNbaUrl' object.")
            return
        }
        
        let dataTask = URLSession(configuration: .default).dataTask(with: todaysNbaUrl) { (data, response, error) in
            if let error = error {
                print(error)
                completion?(false)
                return
            }
            guard let data = data else {
                print("error unwrapping 'data' object -getTodaysNbaData()")
                completion?(false)
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])

            if let dict = json as? [String: Any] {
                if let array = dict["games"] as? [Dictionary<String, Any>], let innerDict = array.first {
                    print(innerDict)
                    completion?(true)
                }
//                print(dict["games"] as Any)
            }
        }
        dataTask.resume()
    }
}


