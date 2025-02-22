//
//  Habit.swift
//  HabitMap
//
//  Created by admin26 on 22/02/25.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var completionDates: [Date] = [] // Stores completed days
    var streak: Int {
        calculateStreak()
    }

    private func calculateStreak() -> Int {
        let sortedDates = completionDates.sorted(by: >)
        guard let latestDate = sortedDates.first else { return 0 }

        var streakCount = 1
        var previousDate = latestDate

        for date in sortedDates.dropFirst() {
            if let nextDay = Calendar.current.date(byAdding: .day, value: -1, to: previousDate),
               Calendar.current.isDate(date, inSameDayAs: nextDay) {
                streakCount += 1
                previousDate = date
            } else {
                break
            }
        }

        return streakCount
    }
}
