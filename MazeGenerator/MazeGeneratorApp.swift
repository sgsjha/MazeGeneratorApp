//
//  MazeGeneratorApp.swift
//  MazeGenerator
//
//  Created by Sarthak Jha on 01/07/2024.
//

import SwiftUI

@main
struct MazeGeneratorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
