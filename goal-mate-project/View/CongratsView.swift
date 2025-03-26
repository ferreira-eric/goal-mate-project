//
//  CongratsView.swift
//  goal-mate-project
//
//  Created by User on 26/03/25.
//

import SwiftUI

import SwiftUI
import SwiftData

struct CongratsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @AppStorage("points") var points = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Image("goal")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 180)
            
            Spacer().frame(height: 5)
            
            Text("Parabéns!")
                .font(.largeTitle)
                .bold()
            
            Text("Você acabou de ganhar 100 pontos!")
                .font(.title3)
                .multilineTextAlignment(.center)
            
            Text("Mantenha o foco para ganhar ainda mais.")
                .font(.body)
                .multilineTextAlignment(.center)
            
            Button(action: {
                addPoints(100)
                dismiss()
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
        .cornerRadius(15)
    }
    
    private func addPoints(_ value: Int) {
        points = points + value
    }
}

#Preview {
    CongratsView()
}
