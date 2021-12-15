//
//  TrainingView.swift
//  HealthApp
//
//  Created by Łukasz on 02/12/2021.
//

import SwiftUI

var audioPlayer = AudioPlayer()

func formatTime(time: Int) -> String{
    var seconds = String(time%60)
    var minutes = String(time/60)
    if seconds.count == 1{
        seconds = "0"+seconds
    }
    if minutes.count == 1{
        minutes = "0"+minutes
    }
    return minutes + " : " + seconds
}

struct ExercisesView: View {
    @EnvironmentObject var training: CurrentTraining
    
    @Binding var exercisesDone: Int
    @Binding var exercisesSkipped: Int
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    @State var startingTime = 5
    @State var trainingTime = 0
    @State var message = "5"
    @State var started = false
    var body: some View{
        VStack(spacing: 15){
            Text(training.name)
                .font(.system(size: 45,weight: .bold ,design: .serif))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            
            Image(training.image)
                .resizable()
                .scaledToFit()
            
            Text(message)
                .font(.system(size: 30,weight: .bold ,design: .serif))
                .foregroundColor(Color(red:170/255, green:40/255, blue:0/255))
                .onReceive(timer){ (_) in
                    if startingTime > 1{
                        startingTime = startingTime - 1
                        message = String(startingTime)
                        audioPlayer.playSystemSound(soundId: 1001)
                    }
                    else if startingTime == 1 && message != "START"{
                        audioPlayer.playSystemSound(soundId: 1000)
                        self.timer.upstream.connect().cancel()
                        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                        started = true
                        audioPlayer.playMusic(name: "mortalcombat", type: "mp3", loops: -1)
                        message = "START"
                    }
                }
            
            Text(formatTime(time: trainingTime))
                .font(.system(size: 50,weight: .bold ,design: .serif))
                .foregroundColor(Color(red:200/255, green:100/255, blue:0/255))
                .onReceive(timer){ (_) in
                    if started{
                        if trainingTime > 1{
                            trainingTime = trainingTime - 1
                        }
                        else{
                            audioPlayer.playSystemSound(soundId: 1000)
                            exercisesDone = exercisesDone + 1
                            audioPlayer.stopPlaying()
                            training.pauseToggle()
                        }
                    }
                }
            
            Button("Pomiń"){
                exercisesSkipped = exercisesSkipped + 1
                audioPlayer.stopPlaying()
                training.pauseToggle()
            }.buttonStyle(TrainingButton())
            
            Button("Zakończ"){
                audioPlayer.stopPlaying()
                presentationMode.wrappedValue.dismiss()
            }.buttonStyle(CustomButton())
        }
        .onAppear(perform: {
            trainingTime = training.minutesOfExercises * 60
        })
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}


struct RestingView: View {
    @EnvironmentObject var training: CurrentTraining
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var restingTime = 0
    var body: some View{
        VStack(spacing: 20){
            Text("Czas na przerwę")
                .font(.system(size: 45,weight: .bold ,design: .serif))
                .foregroundColor(.white)

            Image("resting")
                .resizable()
                .scaledToFit()
            
            Text(formatTime(time: restingTime))
                .font(.system(size: 45,weight: .bold ,design: .serif))
                .foregroundColor(Color(red:0/255, green:0/255, blue:250/255))
                .onReceive(timer){ (_) in
                    if restingTime > 1{
                        restingTime = restingTime - 1
                    }
                    else{
                        audioPlayer.playSystemSound(soundId: 1000)
                        training.pauseToggle()
                    }
                    
                }
            
            Button("Pomiń"){
                training.pauseToggle()
            }.buttonStyle(TrainingButton())
            
            Button("Zakończ"){
                presentationMode.wrappedValue.dismiss()
            }.buttonStyle(CustomButton())
        }
        .onAppear(perform: {
            restingTime = training.minutesOfResting * 60
        })
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct FinishView: View {
    @EnvironmentObject var training: CurrentTraining
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View{
        VStack(spacing: 20){
            Text("Gratulacje!")
                .font(.system(size: 50,weight: .bold ,design: .serif))
                .foregroundColor(.white)
            
            Text("Ukończyłeś trening:")
                .font(.system(size: 30,weight: .bold ,design: .serif))
                .foregroundColor(.white)
            
            Text(training.name)
                .font(.system(size: 25,weight: .bold ,design: .serif))
                .foregroundColor(.white)
            
            Image(training.image)
                .resizable()
                .scaledToFit()
            
            Button("Zakończ"){
                presentationMode.wrappedValue.dismiss()
            }.buttonStyle(CustomButton())
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct TrainingView: View {
    @EnvironmentObject var training: CurrentTraining
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var exercisesDone = 0
    @State var exercisesSkipped = 0
    var body: some View {
        return Group {
            if  exercisesDone == training.numberOfExercises || exercisesSkipped == training.numberOfExercises{
                FinishView()
            }
            else if !training.paused{
                ExercisesView(exercisesDone: $exercisesDone, exercisesSkipped: $exercisesSkipped)
            }
            else{
                RestingView()
            }
        }
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        RestingView()
            .preferredColorScheme(.dark)
    }
}
