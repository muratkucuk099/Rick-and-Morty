//
//  LocationManager.swift
//  RickAndMorty
//
//  Created by Mac on 13.04.2023.
//

import Foundation

class CharacterManager {
    
    func performRequest(url: URL, completion: @escaping (Result<[CharacterData], Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("Error: \(error)")
                return
            } else if let data = data {
                let characters = self.parseJSON(data)
                if let characters = characters {
                    completion(.success(characters))
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(_ characterData: Data) -> [CharacterData]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CharacterData.self, from: characterData)
            var characters: [CharacterData] = []
            
                let origin = Origin(name: decodedData.origin.name)
                let id = decodedData.id
                let name = decodedData.name
                let status = decodedData.status
                let species = decodedData.species
                let type = decodedData.type
                let gender = decodedData.gender
                let image = decodedData.image
                let episode = decodedData.episode
                let created = decodedData.created
            let location = decodedData.location
                let anyCharacter = CharacterData(id: id, name: name, status: status, species: species, type: type, gender: gender, origin: origin, image: image, episode: episode, created: created, location: location)
                characters.append(anyCharacter)
            return characters
        } catch {
            print(error)
            return nil
        }
    }
    func getCharacter(residentUrls: [String], completion: @escaping ([CharacterData]?, Error?) -> Void) {
        var characterArray = [CharacterData]()
        let dispatchGroup = DispatchGroup()
        
        for url in residentUrls {
            dispatchGroup.enter()
            
            if let urlUrl = URL(string: url) {
                CharacterManager().performRequest(url: urlUrl) { result in
                    switch result {
                    case .success(let characters):
                        characterArray.append(contentsOf: characters)
                    case .failure(let error):
                        completion(nil, error)
                        return
                    }
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion(characterArray, nil)
        }
    }

}



