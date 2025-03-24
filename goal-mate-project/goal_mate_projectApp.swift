//
//  goal_mate_projectApp.swift
//  goal-mate-project
//
//  Created by User on 18/03/25.
//

import SwiftUI
import SwiftData

@main
struct goal_mate_projectApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView() // O ponto de entrada é o TabView principal
        }
        .modelContainer(for: [GoalModel.self, TaskModel.self]) // Mantendo os containers
    }
}

struct MainTabView: View {
    init() {
        // Configurando a aparência da UITabBar globalmente
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white // Cor de fundo da TabBar
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.orange // Ícone selecionado laranja
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange] // Texto selecionado laranja
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightGray // Ícone não selecionado cinza
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray] // Texto não selecionado cinza
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            // Aba "Metas"
            NavigationStack {
                GoalView()
            }
            .tabItem {
                Image(systemName: "flag.fill")
                Text("Metas")
            }

            // Aba "Adicionar Atividade"
            NavigationStack {
                AddActivityView()
            }
            .tabItem {
                Image(systemName: "chart.bar.fill")
                Text("Progresso")
            }
        }
    }
}
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
