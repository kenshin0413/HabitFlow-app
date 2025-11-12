//
//  DailyStat.swift
//  HabitFlow
//
//  Created by miyamotokenshin on R 7/11/12.
//

import Foundation

struct DailyStat: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}
