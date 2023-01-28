//
//  File.swift
//  UnitTestinDemoApp
//
//  Created by Waseem Wani on 26/01/23.
//

import Foundation

protocol NetworkService {
    func fetch(completion: @escaping ([Todo]?, Error?) -> Void)
}

class NetworkManager: NetworkService {
    
    func fetch(completion: @escaping ([Todo]?, Error?) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
            debugPrint("failed to create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(nil, error)
            } else if let data = data {
                do {
                    var decodeData = try JSONDecoder().decode([Todo].self, from: data)
                    decodeData.removeLast(188)
                    completion(decodeData, nil)
                } catch (let error) {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
