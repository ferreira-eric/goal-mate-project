import SwiftUI

struct CongratsView: View {
    @AppStorage("points") private var points: Int = 0 // Persiste os pontos entre sessões

    var body: some View {
        VStack(spacing: 20) {
            // Imagem personalizada dos Assets
            Image("goalPlaceholder")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            // Texto de congratulação
            Text("Parabéns!")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.orange)

            Text("Você acabou de ganhar 100 pontos!")
                .font(.title3)
                .multilineTextAlignment(.center)

            Text("Mantenha o foco para ganhar ainda mais.")
                .font(.body)
                .multilineTextAlignment(.center)

            // Botão para "Receber"
            Button(action: {
                points = PointsModel.addPoints(currentPoints: points) // Atualiza os pontos usando o modelo
                print("Total de pontos: \(points)")
            }) {
                Text("Receber")
                    .font(.headline)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            // Display dos pontos acumulados
            Text("Total de pontos: \(points)")
                .font(.title3)
                .bold()
                .foregroundColor(.green)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(15)
        .navigationTitle("Parabéns!")
    }
}

// Preview da tela
struct CongratsView_Previews: PreviewProvider {
    static var previews: some View {
        CongratsView()
    }
}
