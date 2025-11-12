//
//  StatsView.swift
//  HabitFlow
//
//  Created by miyamotokenshin on R 7/11/12.
//

import SwiftUI
import Charts

struct StatsView: View {
    @EnvironmentObject var vm: HabitViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("過去7日間の達成状況")
                .font(.title2.bold())
            
            let stats = vm.makeStats()
            
            if stats.isEmpty {
                Text("まだデータがありません")
                    .foregroundColor(.gray)
                    .padding(.top, 40)
            } else {
                Chart {
                    ForEach(stats) { day in
                        BarMark(
                            x: .value("日付", day.date, unit: .day),
                            y: .value("達成率", day.count)
                        )
                        .foregroundStyle(.blue.gradient)
                    }
                }
                .frame(height: 240)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("統計")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    StatsView()
        .environmentObject(HabitViewModel())
}
