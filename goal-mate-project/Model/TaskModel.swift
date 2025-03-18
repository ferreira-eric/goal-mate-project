//
//  TaskModel.swift
//  goal-mate-project
//
//  Created by User on 18/03/25.
//
import Foundation
import Observation

import SwiftData

@Model
class TaskModel {
    var name: String
    var date: Date
    var time: Date
    var isDone: Bool
    var goalModel: GoalModel? // Many for One

    
    init(name: String, date: Date, time: Date, goalModel: GoalModel?, isDone: Bool = false) {
        self.name = name
        self.date = date
        self.time = time
        self.isDone = isDone
        self.goalModel = goalModel
    }
}
