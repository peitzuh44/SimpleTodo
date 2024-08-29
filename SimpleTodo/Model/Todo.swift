//
//  Todo.swift
//  SimpleTodo
//
//  Created by Pei-Tzu Huang on 2024/8/27.
//

import Foundation

struct Todo: Identifiable, Codable {
    var id: String
    var createdBy: String
    var timeCreated: Date
    var name: String
    var due: Date
    var isDone: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdBy
        case timeCreated
        case name
        case due
        case isDone
    }
}
