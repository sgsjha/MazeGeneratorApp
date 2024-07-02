//
//  ContentView.swift
//  MazeGenerator
//
//  Created by Sarthak Jha on 01/07/2024.
//

import SwiftUI
import CoreData
import Foundation


struct ContentView: View {
    
    // initialize maser object
    @StateObject private var maze = Maze(rows: 21, cols: 21)

    var body: some View {
        
        ZStack{
            Color.gray.ignoresSafeArea().opacity(0.4)
            
            VStack {
                Spacer().frame(width: 100, height: 50)
                
                Text("MAZE GENERATOR").font(.largeTitle).bold()
                
                Spacer().frame(width: 100, height: 50)
                
                Text("Start").frame(maxWidth: .infinity, alignment: .leading).padding(.leading).font(.title)
                
                MazeView(maze: maze).padding() // render maze
                
                Text("Finish").frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing).font(.title)
                
                // Generate button
                Button(action: {
                    maze.generateMaze()
                }) {
                    Text("Generate New Maze").font(.title2).bold()
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }
                .padding()
            }
        }
        
       
    }
}

// Maze View
struct MazeView: View {
    
    @ObservedObject var maze: Maze
    
    // init geometry reader
    var body: some View {
        GeometryReader { geometry in
            
            // calculate size of maze to fit into square
            let sideLength = min(geometry.size.width, geometry.size.height)
            let cellWidth = sideLength / CGFloat(maze.grid[0].count)
            let cellHeight = sideLength / CGFloat(maze.grid.count)
            
            // Vertical Stack to hold rows
            VStack(spacing: 0) {
                
                ForEach(0..<maze.grid.count, id: \.self) { row in
                    
                    HStack(spacing: 0) { // Horizontal Stack to hold columns
                        
                        ForEach(0..<maze.grid[row].count, id: \.self) { col in
                            
                            if (row, col) == (0, 0) {  // for first cell (start cell)
                                Rectangle()
                                    .foregroundColor(.green)
                                    .frame(width: cellWidth, height: cellHeight)
                            } 
                            
                            else if (row, col) == (maze.grid.count - 1, maze.grid[0].count - 1) { // for last cell (end cell)
                                Rectangle()
                                    .foregroundColor(.red)
                                    .frame(width: cellWidth, height: cellHeight)
                            } 
                            // all other cells
                            else {
                                Rectangle()
                                    // cell = black  if wall, white if path
                                    .foregroundColor(maze.grid[row][col] == 1 ? .black : .white)
                                    .frame(width: cellWidth, height: cellHeight)
                            }
                        }
                    }
                }
            }
            // maze border
            .frame(width: sideLength, height: sideLength)
            .border(Color.black, width: 1)
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
