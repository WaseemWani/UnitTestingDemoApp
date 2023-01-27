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
    
    func fetchTodos(completion: @escaping (Result) -> Void) {
        NetworkManager().fetch() { [weak self] data, error in
            if var todosData = data {
                todosData.removeLast(188)
                self?.todos = todosData
                completion(.success)
            } else if let err = error {
                completion(.failure(err))
            }
        }
    }
}
