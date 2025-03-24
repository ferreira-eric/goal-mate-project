import SwiftUI

struct ActivityDetail: View {
    var activity: ActivityModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(activity.name)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.orange)

            Text("Descrição:")
                .font(.headline)
            Text(activity.description)
                .font(.body)

            Text("Data de início: \(activity.startDate)")
                .font(.subheadline)
            Text("Data final: \(activity.endDate)")
                .font(.subheadline)
                .foregroundColor(.orange)

            Spacer()
        }
        .padding()
        .navigationTitle(activity.name)
    }
}

// Preview configurado para ActivityDetail
struct ActivityDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetail(activity: ActivityModel(
            name: "Estudar Romantismo",
            description: "Página 17 a 20 do livro, anotações do caderno",
            startDate: "05/06/2025",
            endDate: "06/06/2025",
            timer: "10:00"
        ))
    }
}
