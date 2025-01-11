////
////  MealCardView.swift
////  MealMate
////
////  Created by Mahesh Kumar on 11/01/25.
////
//
import SwiftUI

struct MealCardView: View {
    // A model representing meal details including daytime, timings, progress, and recipes
    let diet: Diet
    
    // State variable to manage the "Select All" toggle
    @State var isAllSelected: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header containing meal name, timings, and progress status
            HStack {
                // Meal name and timings
                VStack(alignment: .leading) {
                    Text(diet.daytime) // Meal type (e.g., Breakfast)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(diet.timings) // Meal timing (e.g., 7:00 AM - 8:00 AM)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()

                // Circular Progress Bar with Text Status
                ProgressRingView(progress: Double(diet.progressStatus.completed) / Double(diet.progressStatus.total))
                    .frame(width: 64, height: 64) // Set progress ring size
                    .overlay(
                        // Overlay progress text showing completed and total tasks
                        Text("Status\n\(diet.progressStatus.completed) / \(diet.progressStatus.total)")
                            .font(.caption)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    )
            }

            // "Select All" button
            Button(action: {
                // Toggle the "Select All" state
                isAllSelected.toggle()
            }) {
                Label {
                    Text("Select All") // Button label text
                        .font(.footnote)
                } icon: {
                    // Button icon for selected/unselected state
                    Image(isAllSelected ? "img_all_select" : "img_all_unselect")
                        .resizable()
                        .frame(width: 24, height: 24) // Set icon size
                }
            }
            .foregroundColor(.black) // Set button text color

            // List of recipes using LazyVStack
            LazyVStack(alignment: .leading, spacing: 12) {
                // Iterate through each recipe and display in a RecipeCardView
                ForEach(diet.recipes) { recipe in
                    RecipeCardView(recipe: recipe, isAllSelectForFeed: $isAllSelected)
                        .padding([.leading, .trailing], 1) // Adjust horizontal padding
                        .frame(maxWidth: .infinity, alignment: .leading) // Set frame size
                        .clipShape(RoundedRectangle(cornerRadius: 12)) // Apply rounded corners
                        .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2) // Optional shadow for elevation
                }
            }
            .padding(.horizontal, -10) // Adjust horizontal padding for LazyVStack
        }
        .padding() // Add overall padding for the entire view
    }
}
