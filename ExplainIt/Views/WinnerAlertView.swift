//
//  WinnerAlertView.swift
//  ExplainIt
//
//  Created by Vakhtang on 23.01.2024.
//

import SwiftUI

struct WinnerAlertView: View {
    @EnvironmentObject var viewModel: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDuration = 30
    @State private var timerDuration = [30]
    @State private var isGameFinish: Bool = false
    var body: some View {
        VStack {
            VStack {
                Group {
                    Text("Winner: ").font(.title2)
                    + Text("\(viewModel.winners)")
                        .font(.title)
                }
                .foregroundStyle(Color.blue)
                .padding()
                .offset(y: -140)
                SettingAnimationView(animationFileName: "astronaut".localized, loopMode: .loop)
                    .frame(width: 100, height: 100)
                    .scaleEffect(0.2)
                    .padding()
            }
            .padding(.bottom)
            VStack {
                CustomButton(name: "Finish".localized) {
                    self.presentationMode.wrappedValue.dismiss()
                    viewModel.resetGame()
                    viewModel.clearGameData()
                }
            }
            .padding()
            .offset(y: 100)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BackgroundView())
    }
}

#Preview {
    WinnerAlertView()
}
