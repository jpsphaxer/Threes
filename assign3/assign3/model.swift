//
//  model.swift
//  assign1
//
//  Created by Josue Proano on 2/11/22.
//

import Foundation


enum Direction {
    case up
    case down
    case left
    case right
}


struct Tile {
    var val : Int
    var id : Int
    var row: Int
    var col : Int
}


class Triples : ObservableObject{
    
    @Published var board: [[Int]] = [[0,1,0,2],[0,0,3,6],[1,2,1,1],[3,3,0,3]]
    @Published var score : Int = 0
    @Published var gameOver : Bool = false
    private var temp_score : Int = 0
    var gen : SeededGenerator = SeededGenerator(seed:UInt64(Int.random(in:1...1000)))
    
    init(){
        //self.board = newgame(choice: true)
//        self.board = [[0,1,0,2],[0,0,3,6],[1,2,1,1],[3,3,0,3]]
//        self.score = 0
//        self.gen = SeededGenerator(seed:14)
//        self.gameOver = false
        newgame(choice: false)
        spawn()
        spawn()
        spawn()
        spawn()
    }

    func newgame(choice: Bool) {
        
        if(choice == true){
            score = 0
            temp_score = 0
            board = Array(repeating: Array(repeating: 0, count: 4),count: 4)
            gen = SeededGenerator(seed:14)
            self.gameOver = false
            
        } else if ( choice == false) {
            score = 0
            temp_score = 0
            board = Array(repeating: Array(repeating: 0, count: 4),count: 4)
            gen = SeededGenerator(seed:UInt64(Int.random(in:1...1000)))
            self.gameOver = false
        }
        
        
    }                   // re-inits 'board', and any other state you define
    
    
    func rotate() {
        
        self.board = rotate2DInts(input: self.board)
    }
    
    func spawn(){
        
        //var seededGenerator = SeededGenerator(seed:14)
        let newRandomNumber = Int.random(in: 1...2, using: &self.gen)
        
        //array for empty spaces
        var b = Array(repeating: Array(repeating: 0, count: 4),count: 4)
        var counter = 0
        
        // getting a board with the indeces of empty places
        // non empty are init to -1
        for r in 0..<4{
            for c in 0..<4{
                
                if(self.board[r][c] == 0){
                    b[r][c] = counter
                    counter += 1
                } else {
                    b[r][c] = -1
                }
            }
        }
        counter -= 1
        //index is supposed to be the place in the empty board where i want to insert 1 or 2
        if (counter > -1){
            let index = Int.random(in: 0...counter, using: &self.gen)

            for r in 0..<4{
                for c in 0..<4{
                    if(b[r][c] == index){
                        self.board[r][c] = newRandomNumber
                        self.score += newRandomNumber
                    }
                }
            }
        }
        if counter == -1 {
            b[3][3] = -1
        }
        //print(b)
        let check = Array(repeating: Array(repeating: -1, count: 4),count: 4)
        
 
        if(b == check){
           // print(b)
           // print(check)
            let s = self.score
            let board = self.board
            
            let left = self.collapse(dir: .left)
            self.score = s
            self.board = board
            
            let right = self.collapse(dir: .right)
            self.score = s
            self.board = board
      
            let up = self.collapse(dir: .up)
            self.board = board
            self.score = s
            
            let down = self.collapse(dir: .down)
            self.board = board
            self.score = s
            
            if(left == false && right == false && up == false && down == false){
                self.gameOver = true
                //print("Game OVER")
            }
        }
    }
    
    
    func isGameOver(){
        var b = Array(repeating: Array(repeating: 0, count: 4),count: 4)
        var counter = 0
        
        // getting a board with the indeces of empty places
        // non empty are init to -1
        for r in 0..<4{
            for c in 0..<4{
                
                if(self.board[r][c] == 0){
                    b[r][c] = counter
                    counter += 1
                } else {
                    b[r][c] = -1
                }
            }
        }
        
        let check = Array(repeating: Array(repeating: -1, count: 4),count: 4)
        
        if(b == check){
            //print(b)
          // print(check)
            let board = self.board
            let s = self.score
            //changed naming just in case there are problems with the enums?
            let leftt = self.collapse(dir: .left)
            self.board = board
            self.score = s
            let rightt = self.collapse(dir: .right)
            self.board = board
            self.score = s
            let upp = self.collapse(dir: .up)
            self.board = board
            self.score = s
            let downn = self.collapse(dir: .down)
            self.board = board
            self.score = s
            
            if(leftt == false && rightt == false && upp == false && downn == false){
                self.gameOver = true
                //print("Game OVER")
            }
        }
    }
    
    
    func shift() {
        
        var output = self.board
        
        self.temp_score = 0
        let size = 4
        
        for r in 1..<size{
            
            for c in 0..<size {
                
                let canMove = output[c][r-1] == 0 && output[c][r] != 0
                let oneNtwo = output[c][r-1] + output[c][r] == 3 &&
                                output[c][r-1] * output[c][r] != 0
                let same = output[c][r-1] == output[c][r] &&
                            output[c][r-1] + output[c][r] >= 6

                let condition = canMove || oneNtwo || same
                
                
                

                

                //let tem = output
                if condition {


                    //print("output")
                    //print(output)
                    //print(tem)
                    //helps when shifting and the temp board is equal to the output then dont add to score
                    output[c][r-1] += output[c][r]
                    output[c][r] = 0
                    //print(output)
                    
             
                }
                if(canMove == false){
                    
                    if(oneNtwo){
                        //self.score += 3
                        self.temp_score += 3
                    }
                    
                    if (same){
                        let temp = output[c][r-1] + output[c][r]
                        self.temp_score += temp
                        //self.score += temp
                    }
                    
                }
            }
        }
        self.board = output
        
    }
    
    
    func collapse(dir: Direction) -> Bool {
        let boardComp  = self.board
        
        switch dir {
        case .left:
            shift()
            if(self.board != boardComp){
                //getScore()
                self.score += self.temp_score
                return true
            } else {
                return false
            }
        case .right:
            rotate()
            rotate()
            shift()
            rotate()
            rotate()
            //boardComp  = self.board
            if(self.board != boardComp){
                //print(self.board)
                //print(boardComp)
                self.score += self.temp_score
                //getScore()
                return true
            } else {
                return false
            }
        case .up:
            rotate()
            rotate()
            rotate()
            shift()
            rotate()
            if(self.board != boardComp){
                self.score += self.temp_score
                //getScore()
                return true
            } else {
                return false
            }
        case .down:
            rotate()
            shift()
            rotate()
            rotate()
            rotate()
            if(self.board != boardComp){
                self.score += self.temp_score
                //getScore()
                return true
            } else {
                return false
            }
            
        }
        
    }
    
    
//    func getScore() {
//
//
//        for r in 0..<4{
//            for c in 0..<4{
//                //self.score += self.board[r][c]
//               //self.score  = Int(pow(3, log2(Double(self.board[r][c]/3) + 1)))
//                let a = 0
//            }
//        }
//    }


}



// class-less function that will return of any square 2D Int array rotated clockwise
public func rotate2DInts(input: [[Int]]) -> [[Int]] {
    
    var output = input
    
    let size = 4
    
    for r in 0..<size{
        for c in 0..<size{
            output[c][size - 1 - r] = input[r][c]
        }
    }
    
    return output
}

public func rotate2D<T>(input: [[T]]) -> [[T]]{
    
    var output = input
    
    let size = 4
    for r in 0..<size{
        
        for c in 0..<size{
            output[c][size - 1 - r] = input[r][c]
        }
    }
    return output
}

