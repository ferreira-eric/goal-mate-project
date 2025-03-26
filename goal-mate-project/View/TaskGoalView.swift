//
//  TaskGoalView.swift
//  goal-mate-project
//
//  Created by User on 24/03/25.
//

import SwiftUI
import SwiftData

struct TaskGoalView: View {
        @Environment(\.modelContext) var modelContext
        @Environment(\.dismiss) var dismiss
        
        @State private var showTaskForm = false
        @State private var selectedTask: TaskModel?
        @State private var selectedTaskToView: TaskModel?
        
        @Query var tasks: [TaskModel]
        
        var goal: GoalModel
        
        var body: some View {
            NavigationStack {
                VStack {
                    if tasks.filter({!$0.isDone}).isEmpty {
                        VStack {
                            Image("goal")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 205, height: 205)
                            
                            Text("Adicione uma atividade da meta!")
                                .font(.headline)
                                .padding(.top, 32)
                            
                            Text("Use o + para adicionar uma atividade para fazer.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 16)
                            Spacer().frame(height: 300)
                        }
                    } else {
                        List {
                            ForEach(tasks.filter { !$0.isDone }) { task in
                                TaskRow(task: task)
                                    .listRowInsets(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 8))
                                    .swipeActions(allowsFullSwipe: false) {
                                        Button(role: .destructive) {
                                            deleteTask(task)
                                        } label: {
                                            Label("Excluir", systemImage: "trash")
                                        }
                                        Button {
                                            selectedTask = task
                                            showTaskForm = true
                                        } label: {
                                            Label("Editar", systemImage: "pencil")
                                        }
                                        .tint(.blue)
                                    }.onTapGesture {
                                        selectedTaskToView = task
                                    }
                            }
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
                .navigationTitle(goal.name)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            selectedTask = nil
                            showTaskForm = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.orange)
                        }
                    }
                }
                .sheet(isPresented: $showTaskForm) {
                    TaskFormView(taskToEdit: selectedTask, goal: goal)
                }
                .navigationDestination(item: $selectedTaskToView, destination: { task in
                    TaskDetailView(task: task)
                })
            }
        }
    
        private func deleteTask(_ task: TaskModel) {
            modelContext.delete(task)
        }
}

#Preview {
    TaskGoalView(goal: GoalModel(name: "nome da meta", initialDate: Date(), finishDate: Date(), isDone: false))
}
