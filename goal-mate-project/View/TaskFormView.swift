//
//  TaskFormView.swift
//  goal-mate-project
//
//  Created by User on 24/03/25.
//

import SwiftUI
import SwiftData

struct TaskFormView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = ""
    @State var description: String = ""
    @State var initialDate: Date = Date()
    @State var finishDate: Date = Date()
    
    @State var time: TimeInterval = 0
    
    @State var endTime: Date = Date()
    
    var taskToEdit: TaskModel?
    var goal: GoalModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Nome da atividade")) {
                    TextField("Nome da atividade", text: $name)
                }
                
                Section(header: Text("Descrição da atividade")) {
                    TextField("Descrição da atividade", text: $description)
                }
                
                Section(header: Text("Data da atividade")) {
                    DatePicker("Data de início", selection: $initialDate, displayedComponents: .date)
                    DatePicker("Data de fim", selection: $finishDate, displayedComponents: .date)
                }
                
                Section(header: Text("Cronômetro")) {
//                    HStack {
//                        Text("Tempo para fazer")
//                        Spacer()
//                        TextField("10:00", value: $time, formatter: timeFormatter)
//                            .keyboardType(.numbersAndPunctuation)
//                            .multilineTextAlignment(.trailing)
//                            .frame(width: 80)
//                    }
                    DatePicker("Tempo para fazer", selection: $endTime, displayedComponents: .hourAndMinute)
                    
                }
            }
            .navigationTitle(taskToEdit == nil ? "Adicionar atividade" : "Editar atividade")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }.tint(.orange)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        saveTask()
                        dismiss()
                    }.tint(.orange)
                }
            }
            .onAppear {
                if let task = taskToEdit {
                    name = task.name
                    description = task.descriptionTask
                    initialDate = task.initialDate
                    finishDate = task.finishDate
                    time = task.time
                }
            }
            .onChange(of: endTime) { oldValue, newValue in
                let startDate = Calendar.current.startOfDay(for: endTime)
                time = endTime.timeIntervalSince(startDate)
                print(time)
            }
        }
    }
    
    private var timeFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter
    }

    private func saveTask() {
        if let task = taskToEdit {
            task.name = name
            task.descriptionTask = description
            task.initialDate = initialDate
            task.finishDate = finishDate
            task.time = time
        } else {
            let newTask = TaskModel(
                name: name,
                initialDate: initialDate,
                finishDate: finishDate,
                time: time,
                goalModel: goal,
                description: description
            )
            newTask.descriptionTask = description
            modelContext.insert(newTask)
        }
    }
}


#Preview {
    TaskFormView(goal: GoalModel(name: "nome da meta", initialDate: Date(), finishDate: Date(), isDone: false))
}
