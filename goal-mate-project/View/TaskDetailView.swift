//
//  SwiftUIView.swift
//  goal-mate-project
//
//  Created by User on 26/03/25.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showTimerView = false
    @State private var showCongratsView = false
    @Bindable var task: TaskModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(task.name)
                .font(.largeTitle.bold())
            
            Text("Descrição: \(task.descriptionTask)")
                .font(.body)
                .foregroundColor(.primary)
                .padding(.top, 8)
            
            Spacer()
            
            HStack {
                Button("Iniciar o timer") {
                    showTimerView = true
                }
                .foregroundColor(.orange)
                
                Spacer().frame(width: 75)

                Button(action: {
                    task.isDone = true
                    showCongratsView = true
                }) {
                    Text("Concluir atividade")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.top, 32)
        }
        .padding()
        .sheet(isPresented: $showTimerView) {
            TimerView(task: task)
        }
        .sheet(isPresented: $showCongratsView) {
            CongratsView()
        }
    }
}


#Preview {
    TaskDetailView(task: TaskModel(
        name: "Name",
        initialDate: Date(),
        finishDate: Date(),
        time: 22,
        goalModel: nil,
        isDone: true,
        description: "descriptionTask descrevendo"
        )
    )
}
