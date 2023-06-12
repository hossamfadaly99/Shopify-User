//
//  Reviews.swift
//  Shopify User
//
//  Created by MAC on 11/06/2023.
//

import Foundation
// Function to generate a random review
struct Reviews {
   private func generateRandomReview() -> String {
        let reviews = [
            "Great product! Highly recommended.",
            "Terrible experience. Would not buy again.",
            "Average quality. Nothing special.",
            "Fantastic customer service. Very impressed!",
            "Not worth the price. Disappointed.",
            "Excellent product. Worth every penny.",
            "Poorly made. Fell apart after a few uses.",
            "Impressive features. Love it!",
            "Doesn't meet expectations. Overrated.",
            "Outstanding quality. Exceeded my expectations.",
            "Bad Quality.",
            "Good matrial."
        ]
        
        let randomIndex = Int.random(in: 0..<reviews.count)
        return reviews[randomIndex]
    }
    
    // Create an array of 20 random reviews
    func getReviews(numberOfReviews : Int) ->[String]{
        var randomReviews = [String]()
        for _ in 1...numberOfReviews {
            let randomReview = generateRandomReview()
            randomReviews.append(randomReview)
        }
        return randomReviews
    }
}
