import Foundation

struct ActivityModel: Identifiable {
    let id = UUID() // Identificador único para cada atividade
    var name: String
    var description: String
    var startDate: String
    var endDate: String
    var timer: String
}

