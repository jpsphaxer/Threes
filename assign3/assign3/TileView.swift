
import Foundation
import SwiftUI


private func backColor(for int: Int) -> Color{
    
    switch (int) {
    case Int(1): return .blue
    case Int(2): return .red
    case Int(3): return .white
    case Int(6): return .orange.opacity(0.7)
    case Int(12): return .red.opacity(0.5)
    case Int(24): return .green.opacity(0.5)
    case Int(48): return .blue.opacity(0.2)
    case Int(96): return .indigo.opacity(0.2)
    case Int(192): return .purple.opacity(0.1)
    default:
        return .gray.opacity(0.50)
    }
}

struct oneTile : View {
    @EnvironmentObject var triples : Triples
    var ind1 : Int
    var ind2 : Int
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    private var size: CGFloat {
        if verticalSizeClass == .regular{
            return 80.0
            
        } else {
            return 70.0
        }
   
    }
    
    var body : some View {
        
        Rectangle().fill(backColor(for: triples.board[ind1][ind2]))
            
            //.animation(.spring(response: 0.5, dampingFraction: 0.4, blendDuration: 0.8))
            .frame(width:size, height:size)
            .padding(1)
            .overlay(Text("\(triples.board[ind1][ind2] > 0 ? String(triples.board[ind1][ind2]) : "")")
                        .font(.system(size:20, weight:.bold)))
    }
    
}



struct TileView : View {
    
    @EnvironmentObject var triples : Triples
    ///@State var moved = false
    //@State var moved : Bool
    @Binding var moved : Bool
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    private var size: CGFloat {
        if verticalSizeClass == .regular{
            return 360.0
            
        } else {
            return 330.0
        }
        
        
        
    }
    
    
    
    var body : some View {
        
        
        VStack{
            HStack{
                oneTile(ind1: 0, ind2: 0).animation(.easeInOut(duration: 1), value: moved)
                oneTile(ind1: 0, ind2: 1).animation(.easeInOut(duration: 1), value: moved)
                oneTile(ind1: 0, ind2: 2).animation(.easeInOut(duration: 1), value: moved)
                oneTile(ind1: 0, ind2: 3).animation(.easeInOut(duration: 1), value: moved)
            }
            HStack{
                oneTile(ind1: 1, ind2: 0).animation(.easeInOut(duration: 1), value: moved)
                oneTile(ind1: 1, ind2: 1).animation(.easeInOut(duration: 1), value: moved)
                oneTile(ind1: 1, ind2: 2).animation(.easeInOut(duration: 1), value: moved)
                oneTile(ind1: 1, ind2: 3).animation(.easeInOut(duration: 1), value: moved)
            }
            HStack{
                oneTile(ind1: 2, ind2: 0).animation(.easeInOut(duration: 1), value: moved)
                oneTile(ind1: 2, ind2: 1).animation(.easeInOut(duration: 1), value: moved)
                oneTile(ind1: 2, ind2: 2).animation(.easeInOut(duration: 1), value: moved)
                oneTile(ind1: 2, ind2: 3).animation(.easeInOut(duration: 1), value: moved)
            }
            HStack{
                oneTile(ind1: 3, ind2: 0).animation(.easeInOut(duration: 1), value: moved)
                oneTile(ind1: 3, ind2: 1).animation(.easeInOut(duration: 1), value: moved)
                oneTile(ind1: 3, ind2: 2).animation(.easeInOut(duration: 1), value: moved)
                oneTile(ind1: 3, ind2: 3).animation(.easeInOut(duration: 1), value: moved)
            }
        
        }.background(Rectangle()
                        .foregroundColor(Color.gray.opacity(0.5))
                        .frame(width:size,height:size))
        
        
//        ZStack{
//            //HStack{
//            oneTile(ind1: 0, ind2: 0).animation(.easeInOut(duration: 1), value: moved).offset(CGSize(width: 85 * 0 , height: 85 * 0))
//                oneTile(ind1: 0, ind2: 1).animation(.easeInOut(duration: 1), value: moved).offset(CGSize(width: 85 * 1, height: 85 * 0))
//                oneTile(ind1: 0, ind2: 2).animation(.easeInOut(duration: 1), value: moved).offset(CGSize(width: 85 * 2 , height: 85 * 0))
//                oneTile(ind1: 0, ind2: 3).animation(.easeInOut(duration: 1), value: moved).offset(CGSize(width: 85 * 3 , height: 85 * 0))
//            //}
//            //HStack{
//                oneTile(ind1: 1, ind2: 0).animation(.easeInOut(duration: 1), value: moved).offset(CGSize(width: 85 * 0 , height: 85 * 1))
//                oneTile(ind1: 1, ind2: 1).animation(.easeInOut(duration: 1), value: moved).offset(CGSize(width: 85 * 1 , height: 85 * 1))
//                oneTile(ind1: 1, ind2: 2).animation(.easeInOut(duration: 1), value: moved).offset(CGSize(width: 85 * 2 , height: 85 * 1))
//                oneTile(ind1: 1, ind2: 3).animation(.easeInOut(duration: 1), value: moved).offset(CGSize(width: 85 * 3 , height: 85 * 1))
//            //}
//            HStack{
//                oneTile(ind1: 2, ind2: 0).animation(.easeInOut(duration: 1), value: moved).offset(CGSize(width: 85 * 0 , height: 85 * 2))
//                oneTile(ind1: 2, ind2: 1).animation(.easeInOut(duration: 1), value: moved).offset(CGSize(width: 85 * 1 , height: 85 * 2))
//                oneTile(ind1: 2, ind2: 2).animation(.easeInOut(duration: 1), value: moved).offset(CGSize(width: 85 * 2 , height: 85 * 2))
//                oneTile(ind1: 2, ind2: 3).animation(.easeInOut(duration: 1), value: moved).offset(CGSize(width: 85 * 3 , height: 85 * 2))
//            //}
//            //HStack{
//                oneTile(ind1: 3, ind2: 0).animation(.easeInOut(duration: 1), value: moved).offset(CGSize(width: 85 * 0 , height: 85 * 3))
//                oneTile(ind1: 3, ind2: 1).animation(.easeInOut(duration: 1), value: moved).offset(CGSize(width: 85 * 1 , height: 85 * 3))
//                oneTile(ind1: 3, ind2: 2).animation(.easeInOut(duration: 1), value: moved).offset(CGSize(width: 85 * 2, height: 85 * 3))
//                oneTile(ind1: 3, ind2: 3).animation(.easeInOut(duration: 1), value: moved).offset(CGSize(width: 85 * 3 , height: 85 * 3))
//            //}
//
//            }.frame(width:size,height:size)
//                .background(Rectangle()
//                        .foregroundColor(Color.gray.opacity(0.5))
//                        .frame(width:size,height:size))
//    }
    
  
    }
}





//struct TileView_Preview : PreviewProvider{
//    @State var moved : Bool = true
//    static var previews: some View{
//        //TileView(moved: $moved)
//        TileView(moved)
//    }
//
//}
