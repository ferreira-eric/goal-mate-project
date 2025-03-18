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
    var finishDate: Date
    var isDone: Bool
    @Relationship(deleteRule: .cascade) var tasks: [Task] = [] // One for many

    
    init(name: String, finishDate: Date, isDone: Bool) {
        self.name = name
        self.finishDate = finishDate
        self.isDone = isDone
    }
}
