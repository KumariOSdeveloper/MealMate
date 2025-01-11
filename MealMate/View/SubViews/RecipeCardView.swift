//
//  RecipeCardView.swift
//  MealMate
//
//  Created by Mahesh Kumar on 11/01/25.
//
import SwiftUI

struct RecipeCardView: View {
    // A model representing recipe details
    let recipe: Recipe
    
    // Binding to toggle "Select All" state from the parent view
    @Binding var isAllSelectForFeed: Bool
    
    // State variable to track whether the recipe is marked as fed
    @State var isfeeded: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) { // Increased spacing between elements
            // Header showing time slot and optional select icon
            HStack {
                // Show the "Select All" icon if the binding is true
                if isAllSelectForFeed {
                    Image("img_all_select") // Select all icon
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                }
                // Recipe time slot
                Text(recipe.timeSlot)
                    .bold()
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
            }

            // Recipe content including image and details
            HStack(alignment: .top, spacing: 12) {
                // Recipe Image - loads asynchronously with a placeholder
                AsyncImage(url: URL(string: recipe.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView() // Display loading indicator while image loads
                }
                .frame(width: 110, height: 110)
                .clipShape(RoundedRectangle(cornerRadius: 8))

                // Recipe Details Section
                VStack(alignment: .leading, spacing: 8) {
                    // Recipe Title and Heart Icon (for like/favorite functionality)
                    HStack {
                        Text(recipe.title)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.primary)
                            .lineLimit(2) // Limit title to two lines if it's too long
                        Spacer()
                        // Heart icon (can be used for like functionality)
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 17, height: 17)
                            .foregroundColor(.gray)
                    }
                    
                    // Recipe Duration (e.g., time needed for the recipe)
                    HStack(spacing: 4) {
                        Image("time_ic_img") // Icon representing time
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.gray)
                        Text("\(recipe.duration) mins") // Display recipe duration in minutes
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .padding(.top, 4)
                    
                    Divider() // Separator line between details and buttons

                    // Button Section (e.g., Customize, Feed)
                    HStack(spacing: 8) {
                        // Customize Button
                        Button(action: {
                            print("Customize button tapped") // Action for customizing the recipe
                        }) {
                            Label {
                                Text("Customize")
                                    .font(.footnote)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 4)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.6)
                                    .foregroundColor(.white)
                            } icon: {
                                Image("img_customise") // Image for the customize button
                            }
                            .background(Color(ColorConstants.butonBgColor))
                            .clipShape(Capsule()) // Round the corners
                        }
                        
                        // Feed Button - only visible if "Select All" is false
                        if !isAllSelectForFeed {
                            Button(action: {
                                // Toggle the feeded state and print the status
                                isfeeded.toggle()
                                print(isfeeded ? "Marked as feeded" : "Marked as unfeeded")
                            }) {
                                Label {
                                    Text("Feed")
                                        .font(.footnote)
                                        .padding(.vertical, 4)
                                        .padding(.horizontal, 4)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.6)
                                        .foregroundColor(isfeeded ? .blue : .gray) // Dynamic text color based on feed state
                                } icon: {
                                    Image(isfeeded ? "img_unfeed" : "img_unfill_circle") // Dynamic image based on feed state
                                }
                                .clipShape(Capsule()) // Round the corners
                                .overlay(
                                    Capsule()
                                        .stroke(Color.gray, lineWidth: 1) // Add border around button
                                )
                            }
                        }
                    }

                    .padding(.top, 4) // Padding for the button section
                }
            }
            .padding() // Padding for the whole recipe content
            .background(Color(ColorConstants.recipeBgColor)) // Background color for the recipe card
            .clipShape(RoundedRectangle(cornerRadius: 12)) // Rounded corners for the card
            .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2) // Shadow for elevation effect

            // Additional Feed button section if "Select All" is true
            if isAllSelectForFeed {
                HStack {
                    // Feed button when select all is active
                    Button {
                        print("Feed button tapped") // Action when the button is tapped
                    } label: {
                        Text("Feed?")
                            .font(.subheadline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .foregroundColor(.white)
                            .background(Color(ColorConstants.butonBgColor))
                            .clipShape(Capsule())
                    }

                    Spacer() // Spacer to push the buttons apart

                    // Cancel button to deactivate "Select All" state
                    Button {
                        isAllSelectForFeed = false // Reset "Select All" state
                    } label: {
                        Text("Cancel?")
                            .font(.subheadline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .foregroundColor(.gray)
                            .overlay(
                                Capsule()
                                    .stroke(Color.gray, lineWidth: 1) // Border for cancel button
                            )
                    }
                }
                .padding(.top, 8) // Padding for the feed/cancel button section
            }
        }
        .padding([.leading, .trailing], 16) // Side padding for the card
        .padding(.vertical, 8) // Vertical padding for better card separation
    }
}



struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(recipe: Recipe(
            id: 1,
            title: "Peach Rice Pudding",
            timeSlot: "06:00",
            duration: 30,
            image: "https://appfeatureimages.s3.amazonaws.com/recipes/Porridge.webp",
            isFavorite: 1,
            isCompleted: 1
        ), isAllSelectForFeed: .constant(true))
        
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

