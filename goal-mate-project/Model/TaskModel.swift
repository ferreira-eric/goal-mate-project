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
    var initialDate: Date
    var finishDate: Date
    var time: TimeInterval
    var isDone: Bool
    var descriptionTask: String
    var goalModel: GoalModel? // Many for One

    
    init(name: String, initialDate: Date, finishDate: Date, time: TimeInterval, goalModel: GoalModel?, isDone: Bool = false, description: String) {
        self.name = name
        self.initialDate = initialDate
        self.finishDate = finishDate
        self.time = time
        self.isDone = isDone
        self.goalModel = goalModel
        self.descriptionTask = description
    }
}
