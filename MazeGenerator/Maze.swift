//
//  Maze.swift
//  MazeGenerator
//
//  Created by Sarthak Jha on 01/07/2024.
//

import Foundation

class Maze: ObservableObject {
    // initialize grid
    @Published var grid: [[Int]]
    private var rows: Int
    private var cols: Int

    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        self.grid = Array(repeating: Array(repeating: 1, count: cols), count: rows) // fill maze with walls
        generateMaze()
    }

    func generateMaze() {
        self.grid = Array(repeating: Array(repeating: 1, count: cols), count: rows)
        
        var stack: [(Int, Int)] = [(0, 0)]
        var visited = Array(repeating: Array(repeating: false, count: cols), count: rows)
        visited[0][0] = true // set 1st cell to visited
        grid[0][0] = 0

        let directions = [(0, -2), (0, 2), (-2, 0), (2, 0)]
        
        /**
         
         */
        while !stack.isEmpty {
            
            let (currentRow, currentCol) = stack.last! // set currenet cell to last
            
            // calculate all potential negithous in all directions (2-steps)
            let potentialNeighbours = directions.map { (direction) in
                (currentRow + direction.0, currentCol + direction.1) }
            
            // check for out of bounds/visited
            let validNeighbours = potentialNeighbours.filter { (row, col) in
                    isInBounds(row, col) && !visited[row][col]
                }.shuffled() // shuffled randomises the path
            
            print(validNeighbours)
            
            // select first neighbour (randomised before)
            if let (nextRow, nextCol) = validNeighbours.first {
                visited[nextRow][nextCol] = true
                stack.append((nextRow, nextCol))
                grid[nextRow][nextCol] = 0 // set cell to path
                
                // Break the wall between current cell and next cell
                        let wallRow = (currentRow + nextRow) / 2
                        let wallCol = (currentCol + nextCol) / 2
                        grid[wallRow][wallCol] = 0
            } else {
                stack.removeLast()
            }
        }
        
        print(grid)
    }
    
    
    // Function to check if cell is inside maze dimensions or not
    private func isInBounds(_ row: Int, _ col: Int) -> Bool {
        return row >= 0 && row < rows && col >= 0 && col < cols
    }
}
