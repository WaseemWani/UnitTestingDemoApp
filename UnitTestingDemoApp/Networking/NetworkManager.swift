//
//  File.swift
//  UnitTestinDemoApp
//
//  Created by Waseem Wani on 26/01/23.
//

import Foundation

protocol NetworkService {
    func fetch(completion: @escaping ([Todo]?, Error?) -> Void)
    func fetchTodo(by id: Int, completion: @escaping (Todo?, Error?) -> Void)
}

class NetworkManager: NetworkService {
    
    func fetchData<T: Codable>(from apiType: APIConfig<T>, completion: @escaping (T?, Error?) -> Void) {
        let urlStr = apiType.baseURL + apiType.endPoint
        guard let url = URL(string: urlStr) else { return }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(nil, error)
            } else if let data = data {
                do {
                    let decodeData = try JSONDecoder().decode(apiType.responseType, from: data)
                    completion(decodeData, nil)
                } catch (let error) {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    func fetch(completion: @escaping ([Todo]?, Error?) -> Void) {
        fetchData(from: APIConfig<[Todo]?>.todoList) { data, error in
            if error != nil {
                completion(nil, error)
            } else if var todoList = data {
                todoList?.removeLast(188)
                completion(todoList, nil)
            }
        }
    }
    
    func fetchTodo(by id: Int, completion: @escaping (Todo?, Error?) -> Void) {
        fetchData(from: APIConfig<Todo?>.todoDetail(id)) { data, error in
            if error != nil {
                completion(nil, error)
            } else if let todoDetails = data {
                completion(todoDetails, nil)
            }
        }
    }
}
