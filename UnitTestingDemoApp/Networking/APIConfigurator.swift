//
//  APIConfigurator.swift
//  UnitTestingDemoApp
//
//  Created by Waseem Wani on 16/02/23.
//

import Foundation

enum APIConfig<T> {
    case todoList
    case todoDetail(Int)
    
    var baseURL: String {
        switch self {
            case .todoList:
                return "https://jsonplaceholder.typicode.com"
            case .todoDetail:
                return "https://jsonplaceholder.typicode.com"
        }
    }
    var endPoint: String {
        switch self {
            case .todoList:
                return "/todos"
            case .todoDetail(let todoId):
                return "/todos/" + "\(todoId)"
        }
    }
    
    var responseType: T.Type {
        switch self {
            case .todoList, .todoDetail:
                return T.self
        }
    }
}
