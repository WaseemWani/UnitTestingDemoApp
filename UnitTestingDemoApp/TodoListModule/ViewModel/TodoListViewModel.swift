//
//  TodoListViewModel.swift
//  UnitTestinDemoApp
//
//  Created by Waseem Wani on 26/01/23.
//

import Foundation

enum Result {
    case success
    case failure(Error)
}

class TodoListViewModel {
    var todos: [Todo] = [Todo]()
    let networkService: NetworkService
    
    init(service: NetworkService) {
        self.networkService = service
    }
    
    func fetchTodos(completion: @escaping (Result) -> Void) {
        networkService.fetch() { [weak self] data, error in
            if let todosData = data {
                self?.todos = todosData
                completion(.success)
            } else if let err = error {
                completion(.failure(err))
            }
        }
    }
}
