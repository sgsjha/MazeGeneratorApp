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
    @StateObject private var maze = Maze(rows: 21, cols: 21)

    var body: some View {
        
        ZStack{
            Color.gray.ignoresSafeArea().opacity(0.4)
            
            VStack {
                Spacer().frame(width: 100, height: 50)
                Text("MAZE GENERATOR").font(.largeTitle).bold()
                Spacer().frame(width: 100, height: 50)
                
                Text("Start").frame(maxWidth: .infinity, alignment: .leading).padding(.leading).font(.title)
                MazeView(maze: maze).padding()
                Text("Finish").frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing).font(.title)
                Button(action: {
                    maze.generateMaze()
                }) {
                    Text("Generate Maze").font(.title2).bold()
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

struct MazeView: View {
    @ObservedObject var maze: Maze

    var body: some View {
        GeometryReader { geometry in
            let sideLength = min(geometry.size.width, geometry.size.height)
            let cellWidth = sideLength / CGFloat(maze.grid[0].count)
            let cellHeight = sideLength / CGFloat(maze.grid.count)
            
            VStack(spacing: 0) {
                ForEach(0..<maze.grid.count, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<maze.grid[row].count, id: \.self) { col in
                            if (row, col) == (0, 0) {
                                Rectangle()
                                    .foregroundColor(.green)
                                    .frame(width: cellWidth, height: cellHeight)
                            } 
                            else if (row, col) == (maze.grid.count - 1, maze.grid[0].count - 1) {
                                Rectangle()
                                    .foregroundColor(.red)
                                    .frame(width: cellWidth, height: cellHeight)
                            } 
                            else {
                                Rectangle()
                                    .foregroundColor(maze.grid[row][col] == 1 ? .black : .white)
                                    .frame(width: cellWidth, height: cellHeight)
                            }
                        }
                    }
                }
            }
            .frame(width: sideLength, height: sideLength)
            .border(Color.black, width: 1)
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
