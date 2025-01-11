//
//  CustomFilterAlert.swift
//  MealMate
//
//  Created by Mahesh Kumar on 11/01/25.
//

import SwiftUI


// Custom Alert View
struct CustomFilterAlert: View {
    @Binding var isPresented: Bool
    @Binding var selectedMealTime: String?
    var onApply: () -> Void
    var onCancel: () -> Void

    var body: some View {
        if isPresented {
            ZStack {
                // Background overlay
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)

                // Alert Box
                VStack(spacing: 20) {
                    Text("Select Meal Time")
                        .font(.headline)
                        .padding(.top)

                    // Meal Time Options
                    VStack(spacing: 10) {
                        Button("Morning Meals") {
                            selectedMealTime = "Morning Meals"
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedMealTime == "Morning Meals" ? Color.blue.opacity(0.2) : Color.clear)
                        .foregroundColor(.black)
                        .cornerRadius(10)

                        Button("Afternoon Meals") {
                            selectedMealTime = "Afternoon Meals"
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedMealTime == "Afternoon Meals" ? Color.blue.opacity(0.2) : Color.clear)
                        .foregroundColor(.black)
                        .cornerRadius(10)

                        Button("Evening Meals") {
                            selectedMealTime = "Evening Meals"
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedMealTime == "Evening Meals" ? Color.blue.opacity(0.2) : Color.clear)
                        .foregroundColor(.black)
                        .cornerRadius(10)

                        Button("Night Meals") {
                            selectedMealTime = "Night Meals"
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedMealTime == "Night Meals" ? Color.blue.opacity(0.2) : Color.clear)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                    .padding()

                    // Action Buttons
                    HStack {
                        Button("Cancel") {
                            onCancel()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button("Apply") {
                            onApply()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding()
                .frame(maxWidth: 300)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
            }
        }
    }
}

