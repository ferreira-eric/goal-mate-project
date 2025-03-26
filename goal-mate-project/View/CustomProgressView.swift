import SwiftUI

struct CustomProgressView: View {
    @State private var points: Int = PointsModel.getCurrentPoints()

    var body: some View {
        VStack(spacing: 20) {
            // Caixa de exibição
            HStack {
                // Ícone ilustrativo
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.orange)
                
                // Informações de progresso
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(points) pontos")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.orange)
                    
                    Text("\(points / 100) atividades concluídas")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer() // Mantém o layout bem alinhado
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(15)
            .shadow(radius: 5)
        }
        .padding()
        .onAppear {
            points = PointsModel.getCurrentPoints() // Atualiza os pontos ao exibir a view
        }
    }
}

// Preview da CustomProgressView
struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView()
    }
}
