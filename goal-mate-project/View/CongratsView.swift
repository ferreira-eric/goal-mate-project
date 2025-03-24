import SwiftUI

struct CongratsView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Imagem personalizada dos Assets
            Image("goalPlaceholder")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100) // Tamanho configurável da imagem
                .foregroundColor(.orange) // Cor será ignorada se for uma imagem completa (não símbolo)

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
                print("Pontos recebidos!")
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
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(15)
        .navigationTitle("Parabéns!")
    }
}

// Preview da tela de congratulações
struct CongratsView_Previews: PreviewProvider {
    static var previews: some View {
        CongratsView()
    }
}
