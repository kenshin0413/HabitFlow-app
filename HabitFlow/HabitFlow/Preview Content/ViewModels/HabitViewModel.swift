//
//  HabitViewModel.swift
//  HabitFlow
//
//  Created by miyamotokenshin on R 7/11/12.
//

import Foundation

@MainActor
final class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    
    func addHabit(title: String) {
        let newHabit = Habit(title: title)
        habits.append(newHabit)
        saveHabits()
    }
    
    func toggleHabit(_ habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        var updated = habit
        
        let today = Calendar.current.startOfDay(for: Date())
        if let last = updated.lastCompletedDate, Calendar.current.isDate(last, inSameDayAs: today) {
            // すでに今日完了済みなら解除
            updated.isCompletedToday = false
            updated.streakCount -= 1
            updated.lastCompletedDate = nil
        } else {
            // 今日初めて完了
            updated.isCompletedToday = true
            updated.streakCount += 1
            updated.lastCompletedDate = today
        }
        // 配列の中身を新しいデータに置き換える
        habits[index] = updated
        saveHabits()
    }
    
    // 保存 (UserDefaultsで簡易実装)
    private func saveHabits() {
        if let data = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(data, forKey: "habits")
        }
    }
    
    // 読み込み
    func loadHabits() {
        guard let data = UserDefaults.standard.data(forKey: "habits"),
              let saved = try? JSONDecoder().decode([Habit].self, from: data) else { return }
        habits = saved
    }
    // 1週間分の習慣データを日付ごとに集計して、グラフ表示用に整理する関数
    func makeStats() -> [DailyStat] {
        var stats: [DailyStat] = []
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        for i in 0..<7 {
            guard let date = calendar.date(byAdding: .day, value: -i, to: today) else { continue }
            
            let count = habits.filter {
                if let last = $0.lastCompletedDate {
                    return calendar.isDate(last, inSameDayAs: date)
                } else {
                    return false
                }
            }.count
            
            let stat = DailyStat(count: count, date: date)
            stats.append(stat)
        }
        
        return stats.sorted(by: { $0.date < $1.date })
    }
}
