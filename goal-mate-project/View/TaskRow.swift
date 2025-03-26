//
//  TaskRow.swift
//  goal-mate-project
//
//  Created by User on 24/03/25.
//

import SwiftUI

struct TaskRow: View {
    var task: TaskModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(task.name)
                .font(.headline)
                .foregroundColor(.black)
            
            if !task.descriptionTask.isEmpty {
                Text("Descrição: \(task.descriptionTask)")
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(0.8))
            }
            
            Text("Data final: \(formattedDate(task.finishDate))")
                .font(.footnote)
                .foregroundColor(.black)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
        .background(Color.white.opacity(0.1), in: .rect(cornerRadius: 10))
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue.opacity(0.7)))
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    TaskRow(
        task: TaskModel(
            name: "Name",
            initialDate: Date(),
            finishDate: Date(),
            time: 22,
            goalModel: nil,
            isDone: true,
            description: "descriptionTask"
        )
    )
    .padding()
}



