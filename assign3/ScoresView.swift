//
//  ScoresView.swift
//  assign3
//
//  Created by Josue Proano on 3/20/22.
//

import Foundation
import SwiftUI


struct Scores : View {
    @EnvironmentObject var scores : ScoreList
    
    
    var body : some View {
        
        VStack{
            Text("High Scores").font(.system(size: 30.0)).fontWeight(.heavy)
       
            List(0..<scores.List.count, id: \.self){ index in
                VStack{
                    Text("Best Score #\(index + 1)").font(.headline)
                Text("Score: \(scores.List[index].score)")
                Text("Date: \(scores.df.string(from:scores.List[index].time))")
                }.padding()
        
            }
        }
    }
    
    
    
    
    
    
}


struct ScoreView_Preview: PreviewProvider{
    @EnvironmentObject var scores : ScoreList

    static var previews: some View{
        Scores().environmentObject(ScoreList())
    }
    
}
