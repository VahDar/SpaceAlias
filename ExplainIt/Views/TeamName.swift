//
//  TeamName.swift
//  ExplainIt
//
//  Created by Vakhtang on 08.01.2024.
//

import SwiftUI

struct TeamName: View {
    @State var teamNames: [String]
    @State private var randomNames = ["Crazy cucumber", "Best", "Pony", "Just a winners", "Manatee"]
    @State private var isSetUpScreenActive = false
    @State private var isAlertPresented = false
    @State private var isWarningAlertPresented = false
    @State private var temporaryTeamName = ""
    @State private var editingTeamIndex: Int?
    @State private var selectedDuration = 30
    @State private var numberOfTeams = 0
    let viewModel = GameViewModel()
    var timerDurations: [Int]
    
    init(selectedDuration: Int, timerDurations: [Int]) {
        let initialTeamCount = 2
        self._teamNames = State(initialValue: (1...initialTeamCount).map { "Team \($0)" })
        self._selectedDuration = State(initialValue: selectedDuration)
        self.timerDurations = timerDurations
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(0..<teamNames.count, id: \.self) { index in
                    HStack {
                        TextField("Team \(index + 1) Name", text: $teamNames[index])
                            .textFieldStyle(PlainTextFieldStyle())
                            .foregroundStyle(.white)
                        Spacer()
                        Text("Random")
                            .onTapGesture {
                                teamNames[index] = randomNames.randomElement() ?? ""
                            }
                            .foregroundStyle(Color.blue)
                        
                    }
                    .padding(.horizontal, 18)
                    .onLongPressGesture {
                        self.temporaryTeamName = self.teamNames[index]
                        self.editingTeamIndex = index
                        self.isAlertPresented = true
                    }
                }
                .onDelete(perform: removeTeam(at:) )
                .listRowBackground(Color.clear)
                CustomButton(name: "Add Team") {
                    addTeam()
                }
                .padding()
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            Text("Press and hold to enter a team name")
                .foregroundStyle(Color.blue)
            Text("Swipe to delete a team")
                .foregroundStyle(Color.blue)
            CustomButton(name: "Next") {
                isSetUpScreenActive = true
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BackgroundView())
        .navigationDestination(isPresented: $isSetUpScreenActive) {
            SetUpScreen(selectedDuration: $selectedDuration, viewModel: viewModel)
        }
        .alert("Team name", isPresented: $isAlertPresented) {
            TextField("Enter Team Name", text: $temporaryTeamName)
            Button("Save") {
                if let editingIndex = editingTeamIndex {
                    teamNames[editingIndex] = temporaryTeamName
                }
            }
            Button("Cancle", role: .cancel) {}
        }
        .alert("Maximum number of teams reached!", isPresented: $isWarningAlertPresented) {
            Button("Ok", role: .cancel) {}
        }
    }
    private func addTeam() {
        if teamNames.count < 11 {
            let newTeamNumber = teamNames.count + 1
            teamNames.append("Team \(newTeamNumber)")
        } else {
            isWarningAlertPresented = true
        }
    }
    
    private func removeTeam(at offsets: IndexSet) {
            teamNames.remove(atOffsets: offsets)
        }
}

#Preview {
    TeamName(selectedDuration: 60, timerDurations: [60])
}
