//
//  GoalRow.swift
//  goal-mate-project
//
//  Created by User on 20/03/25.
//

import SwiftUI
import SwiftData

struct GoalRow: View {
    var goal: GoalModel
    
    var progress: CGFloat {
        let totalDuration = goal.finishDate.timeIntervalSince(goal.initialDate)
        let elapsed = Date().timeIntervalSince(goal.initialDate)
        return min(max(elapsed / totalDuration, 0), 1)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(goal.name)
                .font(.headline)
            
            Text("Data final: \(goal.finishDate.formatted(date: .numeric, time: .omitted))")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Faltam \(daysLeft) dias")
                .font(.caption)
                .foregroundColor(.gray)
            
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .orange))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.orange))
    }
    
    var daysLeft: Int {
        Calendar.current.dateComponents([.day], from: Date(), to: goal.finishDate).day ?? 0
    }
}

#Preview {
    GoalRow(goal: GoalModel(name: "Test", initialDate: Date(), finishDate: Date(), isDone: false))
}
