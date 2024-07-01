//
//  Maze.swift
//  MazeGenerator
//
//  Created by Sarthak Jha on 01/07/2024.
//

import Foundation

class Maze: ObservableObject {
    @Published var grid: [[Int]]
    private var rows: Int
    private var cols: Int

    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        self.grid = Array(repeating: Array(repeating: 1, count: cols), count: rows)
        generateMaze()
    }

    func generateMaze() {
        self.grid = Array(repeating: Array(repeating: 1, count: cols), count: rows)
        
        var stack: [(Int, Int)] = [(0, 0)]
        var visited = Array(repeating: Array(repeating: false, count: cols), count: rows)
        visited[0][0] = true
        grid[0][0] = 0

        let directions = [(0, -2), (0, 2), (-2, 0), (2, 0)]
        
        while !stack.isEmpty {
            let (currentRow, currentCol) = stack.last!
            let neighbours = directions
                .map { (currentRow + $0.0, currentCol + $0.1) }
                .filter { isInBounds($0.0, $0.1) && !visited[$0.0][$0.1] }
                .shuffled()

            if let (nextRow, nextCol) = neighbours.first {
                visited[nextRow][nextCol] = true
                stack.append((nextRow, nextCol))
                grid[nextRow][nextCol] = 0
                grid[(currentRow + nextRow) / 2][(currentCol + nextCol) / 2] = 0
            } else {
                stack.removeLast()
            }
        }
        
        print(grid)
    }

    private func isInBounds(_ row: Int, _ col: Int) -> Bool {
        return row >= 0 && row < rows && col >= 0 && col < cols
    }
}
