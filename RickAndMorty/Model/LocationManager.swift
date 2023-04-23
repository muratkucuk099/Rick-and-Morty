//
//  LocationManager.swift
//  RickAndMorty
//
//  Created by Mac on 13.04.2023.
//

import Foundation
import UIKit

class LocationManager {
    
    func performRequest(url: URL, completion: @escaping ([LocationModel]?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            } else if let data = data {
                let locations = self.parseJSON(data)
                
                if let locations = locations {
                    completion(locations)
                }
            }
        }
        task.resume()
    }
    func parseJSON(_ locationData: Data) -> [LocationModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(LocationData.self, from: locationData)
            let results = decodedData.results
            
            var locations: [LocationModel] = []
            for result in results {
                let name = result.name
                let residents = result.residents
                
                let location = LocationModel(locationsName: name, locationResidentsUrl: residents)
                locations.append(location)
            }
            
            return locations
        } catch {
            print(error)
            return nil
        }
    }
}
