//
//  HabitStore.swift
//  HabitMap
//
//  Created by admin26 on 22/02/25.
//

import SwiftUI

class HabitStore: ObservableObject {
    @Published var habits: [Habit] = [] {
        didSet { saveHabits() }
    }

    init() { loadHabits() }

    func toggleHabitCompletion(for habit: Habit, on date: Date) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            if let existingIndex = habits[index].completionDates.firstIndex(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
                habits[index].completionDates.remove(at: existingIndex)
            } else {
                habits[index].completionDates.append(date)
            }
        }
    }

    func addHabit(name: String) {
        habits.append(Habit(name: name))
    }

    func deleteHabit(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }

    private let key = "habitsData"

    func saveHabits() {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    func loadHabits() {
        if let savedData = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Habit].self, from: savedData) {
            habits = decoded
        }
    }
}
