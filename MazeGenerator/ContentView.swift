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
    @StateObject private var maze = Maze(rows: 11, cols: 11)

    var body: some View {
        VStack {
            MazeView(maze: maze)
                .padding()
            Button(action: {
                maze.generateMaze()
            }) {
                Text("Generate Maze")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
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
                            Rectangle()
                                .foregroundColor(maze.grid[row][col] == 1 ? .black : .white)
                                .frame(width: cellWidth, height: cellHeight)
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
