import SwiftUI

struct AddActivityForm: View {
    @Environment(\.dismiss) var dismiss
    @State private var activityName = ""
    @State private var activityDescription = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var timer = "10:00"
    var onAdd: (String, String, String, String, String) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Nova Atividade").foregroundColor(.orange)) {
                    TextField("Nome da atividade", text: $activityName)
                    TextField("Descrição da atividade", text: $activityDescription)
                    DatePicker("Data de início", selection: $startDate, displayedComponents: .date)
                    DatePicker("Data de fim", selection: $endDate, displayedComponents: .date)
                    TextField("Tempo para fazer", text: $timer)
                }
                .padding(.vertical, 10)
            }
            .navigationTitle("Adicionar Atividade")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Salvar") {
                        if !activityName.isEmpty {
                            let startDateFormatted = formatDate(startDate)
                            let endDateFormatted = formatDate(endDate)
                            onAdd(activityName, activityDescription, startDateFormatted, endDateFormatted, timer)
                            dismiss()
                        }
                    }
                    .foregroundColor(.orange)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                    .foregroundColor(.orange)
                }
            }
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}

// Preview ajustado
struct AddActivityForm_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityForm { _, _, _, _, _ in }
    }
}
