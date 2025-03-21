//
//  AddGoalView.swift
//  goal-mate-project
//
//  Created by User on 20/03/25.
//

import SwiftUI
import SwiftData

struct AddGoalView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State private var name: String = ""
    @State private var initialDate = Date()
    @State private var finishDate = Date().addingTimeInterval(60 * 60 * 24 * 14) //14 days
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Nome da Meta")) {
                    TextField("Ex: Prova de Português", text: $name)
                }
                
                Section(header: Text("Data da Meta")) {
                    DatePicker("Data de início", selection: $initialDate, displayedComponents: .date)
                    DatePicker("Data de fim", selection: $finishDate, displayedComponents: .date)
                }
            }
            .navigationTitle("Nova Meta")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    } .tint(.orange)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        let newGoal = GoalModel(name: name, initialDate: initialDate, finishDate: finishDate, isDone: false)
                        modelContext.insert(newGoal)
                        dismiss()
                    } .tint(.orange)
                }
            }
        }
    }
}

#Preview {
    AddGoalView()
}

