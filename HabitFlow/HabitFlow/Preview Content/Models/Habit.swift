//
//  Habit.swift
//  HabitFlow
//
//  Created by miyamotokenshin on R 7/11/12.
//

import Foundation

struct Habit: Identifiable, Codable {
    let id: UUID
    var title: String
    var isCompletedToday: Bool
    var streakCount: Int
    var lastCompletedDate: Date?
    
    init(id: UUID = UUID(), title: String, isCompletedToday: Bool = false, streakCount: Int = 0, lastCompletedDate: Date? = nil) {
        self.id = id
        self.title = title
        self.isCompletedToday = isCompletedToday
        self.streakCount = streakCount
        self.lastCompletedDate = lastCompletedDate
    }
}
