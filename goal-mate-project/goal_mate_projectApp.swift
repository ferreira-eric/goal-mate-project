//
//  goal_mate_projectApp.swift
//  goal-mate-project
//
//  Created by User on 18/03/25.
//

import SwiftUI
import SwiftData

@main
struct goal_mate_projectApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView()
        }
        .modelContainer(for: [GoalModel.self])
        .modelContainer(for: [TaskModel.self])
    }
}
