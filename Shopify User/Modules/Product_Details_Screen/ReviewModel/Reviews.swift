//
//  Reviews.swift
//  Shopify User
//
//  Created by MAC on 11/06/2023.
//

import Foundation
// Function to generate a random review
struct Reviews {
   private func generateRandomReview() -> (String,String,String) {
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
        let imgs = [
            "reviewer1",
            "reviewer2",
            "reviewer3",
            "reviewer4",
            "reviewer5",
            "reviewer7",
            "reviewer10"
        ]
       let names = [
           "Ali Ahmed",
           "Salah Mansour",
           "Alaa Elsayed",
           "Hossam Fadaly",
           "Yossef Elbtat",
           "Zyad Kamal",
           "Malek Mohamed",
           "Yosef Elsayed",
           "Ahmed Gamal",
           "Mohamed Mostafa"
       ]
        let randomReviewIndex = Int.random(in: 0..<reviews.count)
        let randomNameIndex = Int.random(in: 0..<names.count)
        let randomImgIndex = Int.random(in: 0..<imgs.count)
        return (reviews[randomReviewIndex],names[randomNameIndex],imgs[randomImgIndex])
    }
    
    // Create an array of 20 random reviews
    func getReviews(numberOfReviews : Int) ->[(String,String,String)]{
        var randomReviews = [(String,String,String)]()
        for _ in 1...numberOfReviews {
            let randomReview = generateRandomReview()
            randomReviews.append(randomReview)
        }
        return randomReviews
    }
}
