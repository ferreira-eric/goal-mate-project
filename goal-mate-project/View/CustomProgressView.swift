import SwiftUI

struct CustomProgressView: View {
    @State private var points: Int = PointsModel.getCurrentPoints()

    var body: some View {
        VStack(spacing: 20) {
            // Título e caixa agrupados no topo
            VStack(spacing: 10) {
                Text("Progresso")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.top, 20) // Espaçamento do topo
                // Caixa de exibição
                HStack {
                    // Ícone ilustrativo
                    Image("goalPlaceholder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)

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

                    Spacer() // Mantém o layout alinhado
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(15)
                .shadow(radius: 5)
            }
            .frame(maxWidth: .infinity, alignment: .top) // Garante que fique no topo
            .padding(.top, 20) // Espaçamento adicional na parte superior

            Spacer() // Preenche o restante da tela
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
