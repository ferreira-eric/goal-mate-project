//
//  Untitled.swift
//  goal-mate-project
//
//  Created by User on 18/03/25.
//

import Foundation
import Observation

import SwiftData

@Model
class GoalModel {
    var name: String
    var initialDate: Date
    var finishDate: Date
    var isDone: Bool
    @Relationship(deleteRule: .cascade) var tasks: [TaskModel] = [] // One for many

    
    init(name: String, initialDate: Date, finishDate: Date, isDone: Bool) {
        self.name = name
        self.initialDate = initialDate
        self.finishDate = finishDate
        self.isDone = isDone
    }
}
