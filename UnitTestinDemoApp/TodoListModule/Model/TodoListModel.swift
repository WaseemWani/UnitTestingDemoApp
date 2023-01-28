//
//  TodoListModel.swift
//  UnitTestinDemoApp
//
//  Created by Waseem Wani on 28/01/23.
//

import Foundation

struct Todo: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let completed: Bool?
}

