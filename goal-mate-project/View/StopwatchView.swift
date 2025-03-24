import SwiftUI
import AVFoundation

struct StopwatchView: View {
    @State private var activities: [ActivityModel] = [
        ActivityModel(name: "Estudar Romantismo", description: "Página 17 a 20 do livro, anotações do caderno", startDate: "05/06/2025", endDate: "06/06/2025", timer: "10:00")
    ]
    @State private var selectedActivity: ActivityModel? // Para armazenar a atividade selecionada
    @State private var navigateToCongrats = false       // Controla a navegação para CongratsView
    @State private var timeRemaining = 30              // 30 segundos para teste
    @State private var timerIsRunning = false          // Controla o estado do cronômetro
    @State private var timer: Timer?                   // Referência para o cronômetro
    private var alarmSound: AVAudioPlayer?

    var body: some View {
        NavigationStack {
            List {
                ForEach(activities) { activity in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(activity.name)
                            .font(.headline)
                            .foregroundColor(.orange)

                        Text("Descrição: \(activity.description)")
                            .font(.subheadline)

                        Text("Data final: \(activity.endDate)")
                            .font(.subheadline)
                            .foregroundColor(.orange)

                        VStack {
                            // Cronômetro funcional
                            ZStack {
                                Circle()
                                    .stroke(lineWidth: 10)
                                    .foregroundColor(.orange.opacity(0.3))
                                Circle()
                                    .trim(from: 0, to: CGFloat(timeRemaining) / 600)
                                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                    .foregroundColor(.orange)
                                    .rotationEffect(Angle(degrees: -90))
                                    .animation(.linear, value: timeRemaining)
                                Text("\(timeString(time: timeRemaining))")
                                    .font(.headline)
                                    .foregroundColor(.orange)
                                    .bold()
                            }
                            .frame(width: 150, height: 150)
                            .padding()

                            // Botões lado a lado
                            HStack {
                                Button(action: {
                                    toggleTimer() // Pausar/Iniciar o cronômetro
                                }) {
                                    Text(timerIsRunning ? "Pausar" : "Iniciar Timer")
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.orange)
                                        .padding()
                                        .frame(width: 150)
                                        .background(Color.clear)
                                        .cornerRadius(10)
                                }
                                .buttonStyle(.borderless) // Sem estilo de borda

                                Button(action: {
                                    stopTimer() // Para o cronômetro
                                    navigateToCongrats = true // Navega para CongratsView
                                }) {
                                    Text("Concluir Atividade")
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(width: 150)
                                        .background(Color.orange)
                                        .cornerRadius(10)
                                }
                                .buttonStyle(.borderless) // Sem estilo de borda
                            }
                        }
                    }
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(12)
                }
            }
            .navigationDestination(isPresented: $navigateToCongrats) {
                CongratsView() // Navega para CongratsView
            }
            .navigationTitle("Cronômetro de Atividade")
            .onAppear {
                startTimer() // Inicia o cronômetro ao aparecer
            }
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
                playAlarm() // Toca o alarme quando o tempo termina
            }
        }
        timerIsRunning = true
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timerIsRunning = false
    }

    func toggleTimer() {
        if timerIsRunning {
            stopTimer() // Pausa o cronômetro
        } else {
            startTimer() // Inicia o cronômetro
        }
    }

    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func playAlarm() {
        guard let path = Bundle.main.path(forResource: "alarm", ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: path)

        do {
            let alarmSound = try AVAudioPlayer(contentsOf: url)
            alarmSound.play()
        } catch {
            print("Erro ao tocar o alarme: \(error.localizedDescription)")
        }
    }
}

#Preview {
    StopwatchView()
}
