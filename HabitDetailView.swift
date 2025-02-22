//
//  HabitDetailView.swift
//  HabitMap
//
//  Created by admin26 on 22/02/25.
//
import SwiftUI

struct HabitDetailView: View {
    var habit: Habit
    @ObservedObject var habitStore: HabitStore

    var body: some View {
        VStack {
            Text(habit.name)
                .font(.title)
                .padding()

            // Show a horizontal calendar for tracking days
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<7, id: \.self) { offset in
                        let date = Calendar.current.date(byAdding: .day, value: -offset, to: Date())!
                        let isCompleted = habit.completionDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) })
                        
                        VStack {
                            Text(date, style: .date)
                                .font(.caption)
                            
                            Button(action: {
                                habitStore.toggleHabitCompletion(for: habit, on: date)
                            }) {
                                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(isCompleted ? .green : .gray)
                                    .font(.largeTitle)
                            }
                        }
                        .padding()
                    }
                }
            }
            .padding()
        }
    }
}

