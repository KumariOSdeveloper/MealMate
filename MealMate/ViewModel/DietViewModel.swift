//
//  DietViewModel.swift
//  MealMate
//
//  Created by Mahesh Kumar on 11/01/25.
//

import Foundation
import Combine

class DietViewModel: ObservableObject {
    @Published var diets: [Diet] = []
    @Published var filteredDiets: [Diet] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // Fetch diets data
    func fetchDiets() async {
        isLoading = true
        errorMessage = nil

        let url = URL(string: "https://uptodd.com/fetch-all-diets")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(DietResponse.self, from: data)
            DispatchQueue.main.async {
                self.diets = decodedResponse.data.diets.allDiets
                self.filteredDiets = self.diets // Initialize filteredDiets with all diets
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to load data: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }

    // Filter diets based on search and selected meal time
    func filterMeals(searchText: String, selectedMealTime: String?) {
        if searchText.isEmpty && selectedMealTime == nil {
            // Show all diets if no filters are applied
            filteredDiets = diets
        } else {
            filteredDiets = diets.filter { diet in
                // Check if the diet matches the search query
                let matchesSearchQuery = searchText.isEmpty || diet.daytime.lowercased().contains(searchText.lowercased()) ||
                    diet.timings.lowercased().contains(searchText.lowercased()) ||
                    diet.recipes.contains { recipe in
                        recipe.title.lowercased().contains(searchText.lowercased())
                    }

                // Check if the diet matches the selected meal time
                let matchesMealTime = selectedMealTime == nil || diet.daytime == selectedMealTime

                return matchesSearchQuery && matchesMealTime
            }
        }
    }
}

