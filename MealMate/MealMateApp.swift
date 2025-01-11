//
//  MealMateApp.swift
//  MealMate
//
//  Created by Mahesh Kumar on 10/01/25.
//

import SwiftUI

@main
struct MealMateApp: App {
    @State private var isGroceryListPresented = false
    @State private var isFilterPresented = false

    var body: some Scene {
        WindowGroup {
            NavigationView {
                EveryMealView(
                    onGroceryListTap: {
                        // Trigger navigation to grocery list
                        isGroceryListPresented = true
                    },
                    onFilterTap: {
                        // Trigger filter view
                        isFilterPresented = true
                    }
                )
                .navigationDestination(isPresented: $isGroceryListPresented) {
                    GroceryListView() // Assume this is a view showing the grocery list
                }
                .sheet(isPresented: $isFilterPresented) {
                    FilterView() // Assume this is a view showing filter options
                }
            }
        }
    }
}

struct GroceryListView: View {
    var body: some View {
        Text("Grocery List View")
            .font(.largeTitle)
            .padding()
    }
}

struct FilterView: View {
    var body: some View {
        Text("Filter Options View")
            .font(.largeTitle)
            .padding()
    }
}

