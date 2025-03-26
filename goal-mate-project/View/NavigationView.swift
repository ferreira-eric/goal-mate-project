//
//  NavigationView.swift
//  goal-mate-project
//
//  Created by User on 26/03/25.
//

import SwiftUI

struct NavigationView: View {
    init() {
           let appearance = UITabBarAppearance()
           appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
           appearance.stackedLayoutAppearance.selected.iconColor = UIColor.orange
           appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
           appearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightGray
           appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
           UITabBar.appearance().standardAppearance = appearance
           UITabBar.appearance().scrollEdgeAppearance = appearance
       }

       var body: some View {
           TabView {
               NavigationStack {
                   GoalView()
               }
               .tabItem {
                   Image(systemName: "flag.fill")
                   Text("Metas")
               }

               NavigationStack {
                   Text("Tela de Progresso")
               }
               .tabItem {
                   Image(systemName: "chart.bar.fill")
                   Text("Progresso")
               }
           }
       }
}

#Preview {
    NavigationView()
}
