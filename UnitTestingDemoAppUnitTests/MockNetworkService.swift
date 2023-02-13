//
//  MockNetworkService.swift
//  UnitTestinDemoAppUnitTests
//
//  Created by Waseem Wani on 28/01/23.
//

import Foundation
@testable import UnitTestingDemoApp

class MockNetworkService: NetworkService {
    func fetch(completion: @escaping ([Todo]?, Error?) -> Void) {
        guard let path = Bundle(for: MockNetworkService.self).path(forResource: "MockTodoJSON", ofType: "json") else {
            return
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }
        
        let todos = try? JSONDecoder().decode([Todo].self, from: data)
        completion(todos, nil)
    }
    
    func fetchTodo(by id: Int, completion: @escaping (Todo?, Error?) -> Void) {
        guard let path = Bundle(for: MockNetworkService.self).path(forResource: "MockTodoJSON", ofType: "json") else {
            return
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }
        let allTodos = try? JSONDecoder().decode([Todo].self, from: data)
        let todo = allTodos?.filter({$0.id == id})
        completion(todo?.first, nil)
    }
}
