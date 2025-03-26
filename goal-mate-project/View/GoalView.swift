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

    @State private var selectedGoal: GoalModel? = nil
    @State private var showGoalForm = false
    @State private var selectedGoalNavigation: GoalModel? = nil

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
                } else if goals.filter({!$0.isDone}).isEmpty {
                    VStack {
                        Image("goalPlaceholder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 205, height: 205)
                                            
                        Text("Adicionando mais uma meta!")
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
                        ForEach(goals.filter{ !$0.isDone}) { goal in
                            GoalRow(goal: goal)
                                .listRowInsets(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 8))
                                .swipeActions(allowsFullSwipe: false) {
                                    Button(role: .destructive) {
                                        deleteGoal(goal)
                                    } label: {
                                        Label("Excluir", systemImage: "trash")
                                    }
                                    Button {
                                        selectedGoal = goal
                                        showGoalForm = true
                                    } label: {
                                        Label("Editar", systemImage: "pencil")
                                    }
                                    .tint(.blue)
                                }
                                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                    Button {
                                        goal.isDone = true
                                    } label: {
                                        Label("Concluir", systemImage: "checkmark.circle.fill")
                                    }
                                    .tint(.green)
                                }
                                .onTapGesture {
                                    selectedGoalNavigation = goal
                                }
                        }
                    }
                    .scrollContentBackground(.hidden)

                }
            }
            .navigationTitle("Metas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        selectedGoal = nil
                        showGoalForm = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.orange)
                    }
                }
            }
            .sheet(isPresented: $showGoalForm) {
                GoalFormView(goal: selectedGoal)
            }
            .navigationDestination(item: $selectedGoalNavigation, destination: { goal in
                TaskGoalView(goal: goal)
            })
        }
    }

    private func deleteGoal(_ goal: GoalModel) {
        modelContext.delete(goal)
    }
}

#Preview {
    GoalView()
        .modelContainer(for: GoalModel.self)
}
