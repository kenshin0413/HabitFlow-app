//
//  ContentView.swift
//  HabitFlow
//
//  Created by miyamotokenshin on R 7/11/12.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var vm: HabitViewModel
    @State private var showAddHabit = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if vm.habits.isEmpty {
                    Text("まだ習慣がありません")
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(vm.habits) { habit in
                            HStack {
                                Button {
                                    vm.toggleHabit(habit)
                                } label: {
                                    Image(systemName: habit.isCompletedToday ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(habit.isCompletedToday ? .green : .gray)
                                        .font(.title2)
                                }
                                Text(habit.title)
                                    .font(.headline)
                                Spacer()
                                Text("🔥 \(habit.streakCount)")
                                    .foregroundColor(.orange)
                            }
                            .padding(.vertical, 6)
                        }
                    }
                }
            }
            .navigationTitle("習慣トラッカー")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    showAddHabit = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
            .sheet(isPresented: $showAddHabit) {
                AddHabitView()
            }
            .onAppear {
                vm.loadHabits()
            }
        }
    }
}

#Preview {
    ListView()
        .environmentObject(HabitViewModel())
}
