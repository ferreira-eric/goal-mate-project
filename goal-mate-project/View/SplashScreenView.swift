//
//  SplashScreenView.swift
//  goal-mate-project
//
//  Created by User on 26/03/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        if isActive{
            NavigationView()
        }else{
            VStack{
                VStack{
                    Image("splash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 500)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.isActive = true            }
            }
        }
    }
        }



#Preview {
    SplashScreenView()
}

#Preview {
    SplashScreenView()
}
