//
//  GoalFormView.swift
//  goal-mate-project
//
//  Created by User on 21/03/25.
//
import Foundation

import SwiftUI
import SwiftData

struct GoalFormView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    var goal: GoalModel?

    @State private var name: String = ""
    @State private var initialDate: Date = Date()
    @State private var finishDate: Date = Date().addingTimeInterval(60 * 60 * 24 * 14)

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
            .navigationTitle(goal == nil ? "Nova Meta" : "Editar Meta")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }.tint(.orange)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        saveGoal()
                        dismiss()
                    }.tint(.orange)
                }
            }
            .onAppear {
                if let goal = goal {
                    name = goal.name
                    initialDate = goal.initialDate
                    finishDate = goal.finishDate
                }
            }
        }
    }

    private func saveGoal() {
        if let goal = goal {
            goal.name = name
            goal.initialDate = initialDate
            goal.finishDate = finishDate
        } else {
            let newGoal = GoalModel(name: name, initialDate: initialDate, finishDate: finishDate, isDone: false)
            modelContext.insert(newGoal)
        }

        try? modelContext.save()
    }
}


#Preview {
    GoalFormView()
}
