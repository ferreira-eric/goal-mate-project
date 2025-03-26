//
//  ProgressView.swift
//  goal-mate-project
//
//  Created by User on 26/03/25.
//

import SwiftUI
import SwiftData

struct ProgressAppView: View {
    @Query var goals: [GoalModel]
    @Query var tasks: [TaskModel]
    
    @AppStorage("points") var points = 0
    
    private var totalTasks: Int {
        tasks.count
    }

    private var completedTasks: Int {
        tasks.filter { $0.isDone }.count
    }

    private var achievedGoals: [GoalModel] {
        goals.filter { $0.isDone }
    }

    private var failedGoals: [GoalModel] {
        let now = Date()
        return goals.filter { !$0.isDone && $0.finishDate < now }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Progresso")
                    .font(.largeTitle.bold())
                    .padding(.bottom, 8)
                
                HStack {
                    Image("progress")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110, height: 110)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(points) pontos")
                            .font(.title.bold())
                            .foregroundColor(.orange)

                        Text("\(completedTasks)/\(totalTasks) atividades concluídas")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.orange.opacity(0.5), lineWidth: 2))

                HStack {
                    VStack {
                        Text("Metas atingidas")
                            .font(.subheadline)
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title2)
                        Text("\(achievedGoals.count)")
                            .font(.title.bold())
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).stroke(Color.blue.opacity(0.4), lineWidth: 2))

                    VStack {
                        Text("Metas perdidas")
                            .font(.subheadline)
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.orange)
                            .font(.title2)
                        Text("\(failedGoals.count)")
                            .font(.title.bold())
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).stroke(Color.orange.opacity(0.4), lineWidth: 2))
                }
                Text("Histórico de metas")
                    .font(.title3.bold())
                    .padding(.top)

                VStack(spacing: 12) {
                    ForEach(achievedGoals + failedGoals) { goal in
                        HStack {
                            Image(systemName: goal.isDone ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(goal.isDone ? .blue : .orange)
                                .font(.title2)
                                .padding(.trailing, 8)

                            VStack(alignment: .leading) {
                                Text(goal.name)
                                    .font(.headline)

                                Text(goal.finishDate.formatted(date: .abbreviated, time: .omitted))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            if goal.isDone {
                                Text("+100 pts")
                                    .font(.caption)
                                    .padding(6)
                                    .background(Color.blue.opacity(0.15))
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).stroke(goal.isDone ? Color.blue.opacity(0.4) : Color.orange.opacity(0.4), lineWidth: 1.5))
                    }
                }

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ProgressAppView()
}
