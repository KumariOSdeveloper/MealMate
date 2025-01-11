//
//  ProgressRingView.swift
//  MealMate
//
//  Created by Mahesh Kumar on 11/01/25.
//

import SwiftUI

struct ProgressRingView: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(Color.gray.opacity(0.3))

            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .foregroundColor(.red)
                .rotationEffect(.degrees(-90))

            // Centered text for progress status
            Text(String(format: "%.0f%%", progress * 100))
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}



#Preview {
    ProgressRingView(progress: 40)
}
