//
//  TodoDetailViewModelTests.swift
//  UnitTestingDemoAppUnitTests
//
//  Created by Waseem Wani on 13/02/23.
//

import XCTest
@testable import UnitTestingDemoApp

class TodoDetailViewModelTests: XCTestCase {
    
    func test_when_clicking_on_a_todo_on_todoListScreen_should_fetch_todo_details_successfully() {
        //ARRANGE
        let viewModel = TodoDetailViewModel(todoId: 1, service: MockNetworkService())
        
        //ACT
        viewModel.fetchTodo(by: viewModel.toDoId) { result in
            switch result {
                case .success:
                    
                    //ASSERT
                    XCTAssertEqual(viewModel.todo?.id, 1)
                    XCTAssertEqual(viewModel.todo?.userId, 01)
                    XCTAssertEqual(viewModel.todo?.title, "delectus aut autem")
                    XCTAssertEqual(viewModel.todo?.completed, false)
                default:
                    break
            }
        }
    }
}
