//
//  ContentView.swift
//  GuessThe Flag
//
//  Created by jestin antony on 01/06/20.
//  Copyright © 2020 jestin antony. All rights reserved.
//

import SwiftUI

struct flagImage: ViewModifier {
    func body(content: Content) -> some View{
        content
        
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.black,lineWidth: 1))
        .shadow(color: .black, radius: 2)
    }
}




struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
   
   @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
  @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue,.black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing:30) {
                VStack(spacing:10){
              Text("Tap the flag of ")
                .foregroundColor(.white)
            
                    Text("\(countries[correctAnswer])")
               
                    }
     
        ForEach(0..<3){ number in
            Button(action: {
                self.flagTapped(number: number)
            }) {
                Image(self.countries[number])
                    .renderingMode(.original)
                .modifier(flagImage())
            }
        }
                Text("Current Score:\(userScore)")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            Spacer()

        }
      }
        .alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text("Your score is \(userScore)"), dismissButton: .default(Text("Continue")){
            self.askQuestion()
            })
        }
    }
    
    
    func flagTapped(number:Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore = userScore + 1
        }else{
            scoreTitle = "Wrong,Thats the flag of \(countries[number])"
            userScore = userScore - 1

        }
        showingScore = true
             }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<2)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
