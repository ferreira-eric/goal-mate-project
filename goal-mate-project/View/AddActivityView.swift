import SwiftUI

struct AddActivityView: View {
    @State private var activities: [ActivityModel] = [
        ActivityModel(name: "Estudar Romantismo", description: "Página 17 a 20 do livro, anotações do caderno", startDate: "05/06/2025", endDate: "06/06/2025", timer: "10:00")
    ]
    @State private var showingAddActivity = false
    @State private var selectedActivity: ActivityModel? // Para armazenar a atividade selecionada
    @State private var navigateToCongrats: Bool = false // Controla a navegação para CongratsView
    @State private var navigateToStopwatch: Bool = false // Controla a navegação para StopwatchView

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

                        HStack {
                            // Botão "Iniciar o Timer"
                            Button(action: {
                                navigateToStopwatch = true // Aciona a navegação para StopwatchView
                            }) {
                                Text("Iniciar o Timer")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(.orange)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.clear)
                                    .cornerRadius(10)
                            }

                            // Botão "Concluir Atividade"
                            Button(action: {
                                if let index = activities.firstIndex(where: { $0.id == activity.id }) {
                                    selectedActivity = activities[index] // Seleciona a atividade
                                    activities.remove(at: index)         // Remove da lista
                                    navigateToCongrats = true            // Aciona a navegação para CongratsView
                                }
                            }) {
                                Text("Concluir Atividade")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.orange)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .buttonStyle(.borderless)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(12)
                }
            }
            .navigationDestination(isPresented: $navigateToCongrats) {
                CongratsView() // Navega para CongratsView
            }
            .navigationDestination(isPresented: $navigateToStopwatch) {
                StopwatchView() // Navega para StopwatchView
            }
            .navigationTitle("Prova de Português")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showingAddActivity = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.orange)
                            .font(.title)
                    }
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivityForm { newActivity, description, startDate, endDate, timer in
                    activities.append(ActivityModel(name: newActivity, description: description, startDate: startDate, endDate: endDate, timer: timer))
                }
            }
        }
    }
}

#Preview {
    AddActivityView()
}
