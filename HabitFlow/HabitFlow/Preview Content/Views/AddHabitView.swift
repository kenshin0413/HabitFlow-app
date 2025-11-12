//
//  AddHabitView.swift
//  HabitFlow
//
//  Created by miyamotokenshin on R 7/11/12.
//

import SwiftUI

struct AddHabitView: View {
    @EnvironmentObject var vm: HabitViewModel
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("習慣名（例：運動・読書など）", text: $title)
            }
            .navigationTitle("新しい習慣")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("追加") {
                        if !title.isEmpty {
                            vm.addHabit(title: title)
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    AddHabitView()
        .environmentObject(HabitViewModel()) 
}
