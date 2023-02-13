//
//  TodoDetailViewModel.swift
//  UnitTestingDemoApp
//
//  Created by Waseem Wani on 29/01/23.
//

import Foundation

class TodoDetailViewModel {
    
    let toDoId: Int
    let networkService: NetworkService

    var todo: Todo?
    
    init(todoId: Int, service: NetworkService) {
        self.toDoId = todoId
        self.networkService = service
    }
    
    func fetchTodo(by id: Int, completion: @escaping (Result) -> Void) {
        networkService.fetchTodo(by: id) { [weak self] data, error in
            if let todosData = data {
                self?.todo = todosData
                completion(.success)
            } else if let err = error {
                completion(.failure(err))
            }
        }
    }
}
