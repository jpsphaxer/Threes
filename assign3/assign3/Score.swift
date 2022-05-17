//
//  Score.swift
//  assign3
//
//  Created by Josue Proano on 3/22/22.
//

import Foundation

struct Score : Hashable{
    
    
    var score : Int
    var time : Date
    
    
    func hash(into hasher :inout Hasher) {
        hasher.combine(time)
    }
    
    init(score : Int,time : Date){
        self.score = score
        self.time = time
    }
    
    
    
}


class ScoreList : Identifiable, ObservableObject{
    
    @Published var List = [Score]()
    private var score1 = Score(score: 300, time: Date())
    private var score2 = Score(score: 400, time: Date())
    @Published var df = DateFormatter()
    
    
    
    
    init(){
        df.dateFormat = "MM/d/yyy @ HH:mm:ss"
        List.append(score1)
        List.append(score2)
        self.List = List.sorted{$0.score > $1.score}

    }
    
    func addScore(score:Score){
    
        List.append(score)
        self.List = List.sorted{$0.score > $1.score}
        
    }
    
    
    
    
}
