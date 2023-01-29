//
//  TodoListViewModelTests.swift
//  UnitTestinDemoAppUnitTests
//
//  Created by Waseem Wani on 28/01/23.
//

import XCTest
@testable import UnitTestingDemoApp

class TodoListViewModelTests: XCTestCase {
    
    func test_when_landing_on_todos_screen_fetch_todos_successfully() {
        
        //ARRANGE
        let viewModel = TodoListViewModel(service: MockNetworkService())
        
        //ACT
        viewModel.fetchTodos { result in
            switch result {
                case .success:
                    
                    //ASSERT
                    XCTAssertNotNil(viewModel.todos)
                    XCTAssertGreaterThan(viewModel.todos.count, 1)
                default:
                    break
            }
        }
    }
}
