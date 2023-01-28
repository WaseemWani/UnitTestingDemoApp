//
//  MockNetworkService.swift
//  UnitTestinDemoAppUnitTests
//
//  Created by Waseem Wani on 28/01/23.
//

import Foundation
@testable import UnitTestinDemoApp

class MockNetworkService: NetworkService {
    func fetch(completion: @escaping ([Todo]?, Error?) -> Void) {
        guard let path = Bundle(for: MockNetworkService.self).path(forResource: "MockTodoJSON", ofType: "json") else {
            return
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }
        
        let todos = try? JSONDecoder().decode([Todo].self, from: data)
        completion(todos, nil)
    }
}
