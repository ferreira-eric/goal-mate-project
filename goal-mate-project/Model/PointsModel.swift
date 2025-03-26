import SwiftUI

class PointsModel {
    // Recupera os pontos armazenados no UserDefaults
    static func getCurrentPoints() -> Int {
        return UserDefaults.standard.integer(forKey: "points") // Retorna 0 se não houver valor salvo
    }

    // Adiciona pontos ao total e os salva
    static func addPoints(currentPoints: Int) -> Int {
        let newPoints = currentPoints + 100
        savePoints(newPoints) // Salva os pontos atualizados
        return newPoints
    }

    // Salva os pontos no UserDefaults
    private static func savePoints(_ points: Int) {
        UserDefaults.standard.set(points, forKey: "points")
    }
}
