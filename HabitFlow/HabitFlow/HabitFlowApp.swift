//
//  HabitFlowApp.swift
//  HabitFlow
//
//  Created by miyamotokenshin on R 7/11/12.
//

import SwiftUI

@main
struct HabitFlowApp: App {
    @StateObject var vm = HabitViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(vm)
        }
    }
}
