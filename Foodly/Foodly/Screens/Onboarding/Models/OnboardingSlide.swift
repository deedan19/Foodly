//
//  OnboardingSlide.swift
//  Foodly
//
//  Created by Decagon on 31/05/2021.
//

import UIKit

struct OnboardingSlide {
    let title: String
    let description: String
    let image: UIImage
}

// swiftlint:disable:next line_length
let slide1: OnboardingSlide = OnboardingSlide(title: "Only Healthy Variety", description: "Healthy eating means eating a variety of foods that give you the nutrients you need to maintain your health, feel good and have energy.", image: UIImage(imageLiteralResourceName: "Frame"))

// swiftlint:disable:next line_length
let slide2: OnboardingSlide =  OnboardingSlide(title: "Choose A Tasty Meal", description: "Order anything you want from your favorite restaurant.", image: UIImage(imageLiteralResourceName: "Frame 2"))

// swiftlint:disable:next line_length
let slide3: OnboardingSlide = OnboardingSlide(title: "Easy Payment", description: "Payment made easy through debit card, credit card & more ways to pay for your food..", image: UIImage(imageLiteralResourceName: "Frame 3"))
