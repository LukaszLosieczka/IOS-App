//
//  TrainingMenuView.swift
//  HealthApp
//
//  Created by Łukasz on 04/12/2021.
//

import SwiftUI

struct TrainingMenuView: View {
    @EnvironmentObject var currentUser: CurrentUser
    
    @StateObject var training = CurrentTraining()
    @StateObject var trainings = TrainingsList()
    
    @State private var inProgress: Bool? = false
    @State private var searchText: String = ""
    
    @State var progress: CGFloat = 0
    @State var text: String = "0.0 / 0.0 kcal"
    //@State var trainings: [Dictionary<String, AnyObject>] = getTrainings()
    
    var body: some View {
        ScrollView(showsIndicators: false){
            ZStack{
                NavigationLink(destination: TrainingView().environmentObject(training), tag: true, selection: $inProgress){
                    EmptyView()
                }
                VStack(spacing: 30){
                    ProgressCircle(colors:[Color(red: 199/255, green: 141/255, blue: 32/255)],
                                   width: 250,
                                   height: 250,
                                   textSize: 20,
                                   textColor: Color.white,
                                   lineWidth: 25,
                                   progress: $progress,
                                   text: $text)
                    
                    SearchBar(text: $searchText)
                    HStack{
                        Spacer()
                        VStack(spacing: 0.47){
                            
                            ForEach(trainings.trainingList.filter({ searchText.isEmpty ? true : $0.name.contains(searchText) }), id: \.self.id){ t in
                                
                                Button(action:{
                                    training.setParameters(
                                        name: t.name,
                                        numberOfExercises:t.numberOfExercises,
                                        minutesOfExercises:t.minutesOfExercises,
                                        minutesOfResting:t.minutesOfResting,
                                        caloriesBurned: t.caloriesBurned,
                                        image: t.image)
                                    training.paused = false
                                    inProgress = true
                                }, label: {
                                    HStack{
                                        Spacer()
                                            .frame(width: 15)
                                        Text(t.name)
                                            .font(.system(size: 23, weight: .bold, design: .serif))
                                            .foregroundColor(Color.white)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 7)
                                            .foregroundColor(Color.white)
                                        Spacer()
                                            .frame(width: 20)
                                    }
                                    .frame(maxWidth: 380, minHeight: 60)
                                })
                                    .buttonStyle(MenuButtonStyle())
                                
                            }
                        }
                        .background(Color.gray)
                        .cornerRadius(15)
                        Spacer()
                    }
                }
            }
        }.navigationBarTitle("Trening")
         .onAppear {
             trainings.updateData()
             updateProgress()
         }
    }
    
    func updateProgress(){
        self.progress = (currentUser.user?.lastDay().training)! / currentUser.user!.trainingGoal
        let progressValue = round(10 * self.progress * currentUser.user!.trainingGoal) / 10
        let goal = round(10 * currentUser.user!.trainingGoal) / 10
        self.text = String(progressValue) + " / " + String(goal) + " kcal"
    }
}

struct TrainingMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingMenuView()
    }
}





//func getTrainings() ->[Dictionary<String, AnyObject>]{
//    var result :[Dictionary<String, AnyObject>] = []
//
//    if let path = Bundle.main.path(forResource: "trainings", ofType: "json") {
//        do {
//            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//            if let jsonResult = jsonResult as? [Dictionary<String, AnyObject>]{
//                result = jsonResult
//            }
//        }catch {}
//    }
//    return result
//}

