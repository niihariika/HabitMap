//
//  ContentView.swift
//  HabitMap
//
//  Created by admin26 on 22/02/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var habitStore = HabitStore()
    @State private var showingAddHabit = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(habitStore.habits) { habit in
                        NavigationLink(destination: HabitDetailView(habit: habit, habitStore: habitStore)) {
                            VStack(alignment: .leading) {
                                Text(habit.name)
                                    .font(.headline)
                                Text("🔥 Streak: \(habit.streak) days")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete(perform: habitStore.deleteHabit)
                }

                Button(action: { showingAddHabit = true }) {
                    Text("Add Habit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
            .navigationTitle("Habits")
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView(habitStore: habitStore)
            }
        }
    }
}



#Preview {
    HomeView()
}
