//
//  EveryMealView.swift
//  MealMate
//
//  Created by Mahesh Kumar on 11/01/25.
//

import SwiftUI

struct EveryMealView: View {
    var onGroceryListTap: () -> Void // Closure to handle grocery list tap
    var onFilterTap: () -> Void // Closure to handle filter tap

    @State private var searchText: String = "" // State for search text
    @State private var selectedMealTime: String? = nil // Selected meal time for filter
    @State private var showingFilterAlert = false // To show the custom filter alert
    
    @StateObject private var viewModel = DietViewModel()

    var body: some View {
        VStack(spacing: 16) {
            HeaderView(onGroceryListTap: onGroceryListTap)
            DietStreakView()

            // Search Section
            SearchSection(
                searchText: $searchText,
                onFilterTap: {
                    showingFilterAlert = true // Show filter alert when filter icon is tapped
                }
            )

            // Meal Card Section
            List(viewModel.filteredDiets) { diet in
                MealCardView(diet: diet)
            }
            .padding(.horizontal, -40)
            .listStyle(PlainListStyle())
        }
        .padding()
        .task {
            await viewModel.fetchDiets()
        }
        .onChange(of: searchText) { _ in
            viewModel.filterMeals(searchText: searchText, selectedMealTime: selectedMealTime) // Re-filter when search query changes
        }
        .onChange(of: selectedMealTime) { _ in
            viewModel.filterMeals(searchText: searchText, selectedMealTime: selectedMealTime) // Re-filter when meal time changes
        }
        .overlay(
            CustomFilterAlert(
                isPresented: $showingFilterAlert,
                selectedMealTime: $selectedMealTime,
                onApply: {
                    viewModel.filterMeals(searchText: searchText, selectedMealTime: selectedMealTime) // Apply filter logic
                    showingFilterAlert = false
                },
                onCancel: {
                    selectedMealTime = nil // Reset selection
                    viewModel.filterMeals(searchText: searchText, selectedMealTime: nil) // Reset filter
                    showingFilterAlert = false
                }
            )
        )
    }
}



struct SearchSection: View {
    @Binding var searchText: String
    var onFilterTap: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            HStack {
                Image(systemName: "magnifyingglass") // Magnifying glass icon
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
                
                TextField("Search meals...", text: $searchText)
                    .padding(8)
            }
            .frame(height: 44)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1) // Border color and width
            )

            Spacer(minLength: 20)
            
            // Filter Image
            Image("img_filter") // Replace with actual filter image
                .resizable()
                .frame(width: 40, height: 40)
                .onTapGesture {
                    onFilterTap() // Handle filter tap
                }
        }
        .padding(.horizontal, 8)
    }
}




// MARK: - Header View
struct HeaderView: View {
    var onGroceryListTap: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Everyday Diet Plan")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("Track Ananya’s every meal")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack {
                Image(ImageConstants.img_grocery)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .onTapGesture {
                        onGroceryListTap()
                    }
                Text("Grocery List")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

// MARK: - Diet Streak View
struct DietStreakView: View {
    var body: some View {
        VStack(alignment: .leading) {
            // Title Section
            HStack {
                Text("Diet Streak")
                    .font(.headline)
                Spacer()
                HStack {
                    Image(ImageConstants.img_streak)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("1 Streak")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom, 8)

            // Meal Status Section
            HStack(spacing: 28) {
                MealStatusView(
                    title: "Morning",
                    imageName: ImageConstants.img_consumed,
                    textColor: .gray
                )
                MealStatusView(
                    title: "Afternoon",
                    imageName: ImageConstants.img_cancel,
                    textColor: .red
                )
                MealStatusView(
                    title: "Evening",
                    imageName: ImageConstants.img_current,
                    textColor: .green
                )
                MealStatusView(
                    title: "Night",
                    imageName: ImageConstants.img_pending,
                    textColor: .gray
                )
            }
           
        }
        .padding()
        .background(Color.streakBg)
        .cornerRadius(10)
    }
}

// MARK: - Meal Status View
struct MealStatusView: View {
    let title: String
    let imageName: String
    let textColor: Color

    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(textColor)
            Image(imageName)
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}



#Preview {
    EveryMealView(
        onGroceryListTap: {
            print("Grocery list tapped")
        },
        onFilterTap: {
            print("Filter icon tapped")
        }
    )

}
