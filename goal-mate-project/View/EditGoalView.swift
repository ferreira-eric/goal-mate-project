//
//  EditGoalView.swift
//  goal-mate-project
//
//  Created by User on 20/03/25.
//

import SwiftUI
import SwiftData

struct EditGoalView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Bindable var goal: GoalModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Nome da Meta")) {
                    TextField("Ex: Prova de Português", text: $goal.name)
                }
                
                Section(header: Text("Data da Meta")) {
                    DatePicker("Data de início", selection: $goal.initialDate, displayedComponents: .date)
                    DatePicker("Data de fim", selection: $goal.finishDate, displayedComponents: .date)
                }
            }
            .navigationTitle("Editar Meta")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    } .tint(.orange)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        try? modelContext.save()
                        dismiss()
                    } .tint(.orange)
                }
            }
        }
    }
}

#Preview {
    EditGoalView(goal: GoalModel(name: "Prova de Português", initialDate: Date(), finishDate: Date().addingTimeInterval(60 * 60 * 24 * 14), isDone: false))
}
