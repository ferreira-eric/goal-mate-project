//
//  TimerView.swift
//  goal-mate-project
//
//  Created by User on 26/03/25.
//

import SwiftUI

struct TimerView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isRunning = true
    @State private var remainingTime: TimeInterval
    @State private var initialTime: TimeInterval
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var task: TaskModel
    
    init(task: TaskModel) {
        self.task = task
        _remainingTime = State(initialValue: task.time)
        _initialTime = State(initialValue: task.time)
    }

    var body: some View {
        VStack {
            Text("Foco total!")
                .font(.largeTitle.bold())
                .padding(.top)

            Text("Cada segundo te aproxima do seu objetivo.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 32)

            ZStack {
                Circle()
                    .stroke(Color(.systemGray5), lineWidth: 20)

                Circle()
                    .trim(from: 0, to: CGFloat(remainingTime / initialTime))
                    .stroke(Color.orange.gradient, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .rotationEffect(.degrees(-90))

                Text(formatTime(remainingTime))
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.orange)
            }
            .frame(width: 250, height: 250)
            .padding()

            HStack {
                Button(action: {
                    isRunning.toggle()
                }) {
                    Text(isRunning ? "Pausar" : "Retomar")
                        .foregroundColor(.orange)
                }

                Spacer()

                Button(action: {
                    task.isDone = true
                    dismiss()
                }) {
                    Text("Concluir")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 32)
        }
        .onReceive(timer) { _ in
            guard isRunning else { return }
            if remainingTime > 0 {
                remainingTime -= 1
            }
        }
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


#Preview {
    TimerView(
        task: TaskModel(
        name: "Name",
        initialDate: Date(),
        finishDate: Date(),
        time: 322,
        goalModel: nil,
        isDone: true,
        description: "descriptionTask"
    )
)
}
