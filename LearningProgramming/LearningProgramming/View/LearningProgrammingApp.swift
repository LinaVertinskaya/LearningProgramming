//
//  LearningProgrammingApp.swift
//  LearningProgramming
//
//  Created by Лина Вертинская on 7.03.23.
//

import SwiftUI

@main
struct LearningProgrammingApp: App {
    var body: some Scene {
        let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)

        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
