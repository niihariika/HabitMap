//
//  AddHabitView.swift
//  HabitMap
//
//  Created by admin26 on 22/02/25.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habitStore: HabitStore
    @State private var habitName = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Enter Habit Name", text: $habitName)
            }
            .navigationTitle("New Habit")
            .toolbar {
                Button("Save") {
                    if !habitName.isEmpty {
                        habitStore.addHabit(name: habitName)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
