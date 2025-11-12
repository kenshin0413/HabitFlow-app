//
//  HomeView.swift
//  HabitFlow
//
//  Created by miyamotokenshin on R 7/11/12.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab = 1
    @EnvironmentObject var vm: HabitViewModel
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                ListView()
                    .environmentObject(vm)
            }
            .tabItem {
                Label("習慣リスト", systemImage: "list.bullet")
            }
            .tag(1)
            
            NavigationStack {
                StatsView()
                    .environmentObject(vm)
            }
            .tabItem {
                Label("グラフ", systemImage: "chart.pie.fill")
            }
            .tag(2)
        }
    }
}

#Preview {
    HomeView()
}
