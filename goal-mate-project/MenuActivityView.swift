import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    let title: String
    let description: String?
    let date: Date
    let time: Date
    let completed: Bool
}

struct EnemView: View {
    @State private var tasks = [
        Task(title: "Atividade 1", description: "descrição", date: Date(), time: Date(), completed: false),
        Task(title: "Literatura - pág 21 a 24", description: nil, date: Date(), time: Date(), completed: false),
        Task(title: "Literatura - pág 21 a 24", description: nil, date: Date(), time: Date(), completed: true)
    ]
    
    @State private var showAddTaskSheet = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Cabeçalho
                HStack {
                    Button(action: {
                        // Ação para voltar
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        showAddTaskSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                    }
                }
                .padding()
                
                Text("ENEM")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
                Text("em andamento")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                // Atividades em andamento
                VStack(spacing: 10) {
                    ForEach(tasks.filter { !$0.completed }) { task in
                        TaskCard(task: task)
                    }
                }
                .padding()
                
                Text("concluídas")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                // Atividades concluídas
                VStack(spacing: 10) {
                    ForEach(tasks.filter { $0.completed }) { task in
                        TaskCard(task: task)
                    }
                }
                .padding()
                
                Spacer()
            }
            .sheet(isPresented: $showAddTaskSheet) {
                AddTaskView { newTask in
                    tasks.append(newTask)
                }
            }
        }
    }
}

// Componente para cada atividade
struct TaskCard: View {
    let task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(task.title)
                .font(.headline)
            
            if let description = task.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

// Tela de adicionar nova atividade
struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var date: Date = Date()
    @State private var time: Date = Date()
    
    var onSave: (Task) -> Void
    
    var body: some View {
        VStack {
            TextField("Nome da atividade", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Descrição da atividade", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Text("Data da atividade")
                Spacer()
                DatePicker("", selection: $date, displayedComponents: .date)
                    .labelsHidden()
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            HStack {
                Text("Tempo para fazer")
                Spacer()
                DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                let newTask = Task(title: title, description: description, date: date, time: time, completed: false)
                onSave(newTask)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Salvar")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}

struct EnemView_Previews: PreviewProvider {
    static var previews: some View {
        EnemView()
    }
}

