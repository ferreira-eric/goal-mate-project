//
//  GoalView.swift
//  goal-mate-project
//
//  Created by User on 20/03/25.
//

import SwiftUI
import SwiftData

struct GoalView: View {
    @Environment(\.modelContext) var modelContext
    @Query var goals: [GoalModel]
    @State private var showAddGoal = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if goals.isEmpty {
                    VStack {
                        Image("goalPlaceholder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 205, height: 205)
                        
                        Text("Comece adicionando uma meta!")
                            .font(.headline)
                            .padding(.top, 32)
                        
                        Text("Use o + para adicionar uma meta que você planeja alcançar.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                        Spacer().frame(height: 300)
                    }
                } else {
                    List {
                        ForEach(goals) { goal in
                            GoalRow(goal: goal)
                                .listRowInsets(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 8))
                                .swipeActions {
                                    Button(role: .destructive) {
                                        deleteGoal(goal)
                                    } label: {
                                        Label("Excluir", systemImage: "trash")
                                    }
                                    
                                    Button {
                                        editGoal(goal)
                                    } label: {
                                        Label("Editar", systemImage: "pencil")
                                    }
                                    .tint(.blue)
                                }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Metas")
            .toolbar {
                Button(action: { showAddGoal = true }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.orange)
                }
            }
            .sheet(isPresented: $showAddGoal) {
                AddGoalView()
            }
        }
    }
    
    private func deleteGoal(_ goal: GoalModel) {
        modelContext.delete(goal)
    }
    
    private func editGoal(_ goal: GoalModel) {
        //EditGoalView(goal: goal)
    }
}

#Preview {
    GoalView()
        .modelContainer(for: GoalModel.self)
}
