//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Razvan Dumitriu on 20.03.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var questionCount = 0
    @State private var resetScore = false
    @State private var scoreTitle = ""
    @State private var scorePoints = 0
    
    @State private var countries = [
        "Estonia","France","Germany",
        "Ireland","Italy", "Nigeria",
        "Poland", "Russia", "Spain",
        "UK", "US"
    ].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            AngularGradient(colors: [.red, .green, .blue, .yellow, .purple, .red], center: .center)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scorePoints)")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scorePoints).")
        }
        .alert("Game over!", isPresented: $resetScore) {
            Button("New Game", action: resetGame)
        } message: {
            Text("\(scoreTitle)\nYour score was: \(scorePoints).")
        }
    }
    
    func flagTapped(_ number: Int) {
        questionCount += 1
        if number == correctAnswer {
            scoreTitle = "Correct!"
            scorePoints += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])."
        }
        if questionCount == 8 { resetScore = true }
        else { showingScore = true }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        scorePoints = 0
        questionCount = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
