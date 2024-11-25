//
//  Models.swift
//  KtchnPal
//
//  Created by Vanya Mutafchieva on 14/11/2024.
//

import IdentifiedCollections
import Foundation
import Tagged

struct Recipe: Identifiable, Codable, Equatable {
    var course: Course = .all
    var cuisine: Cuisine? // theme?
    var introduction: String = ""
    let id: Tagged<Self, UUID>
    var images: [String]?
    var ingredients: IdentifiedArrayOf<Ingredient> = []
    var instructions: IdentifiedArrayOf<Instruction> = [] // method?
    var isFavorite: Bool = false
    //var pastCookingSessions: IdentifiedArrayOf<CookingSession> = []
    var servings: Int?
    var source: String = ""
    var thumbnail: String?
    var time: Duration = Duration.seconds(60 * 5) // prepTime, cookTime, marinateTime? totalTime  duration.formatted(.units())
    //var totalTime = ""
    var title: String = ""
    
}

enum Course: String, Codable, CaseIterable, Identifiable {
    case all, breakfast, dessert, dinner, lunch, main, salad, sideDish, snack
    
    var id: Self {
        self
    }
    
    var name: String {
        rawValue.capitalized
    }
}

enum Cuisine: String, Codable, CaseIterable {  // Theme?
    case all, indian, thai, spring, summer, autumn, winter
}

struct Ingredient: Codable, Equatable, Identifiable {
    let id: Tagged<Self, UUID>
    var name: String
    var additionalInfo: String?
    var quantity: String?
    var units: String?
    
    var nameFormatted: String {
        let additionalInfo = self.additionalInfo != nil ? ", " + self.additionalInfo! : ""
        let quantity = self.quantity ?? ""
        let units = self.units ?? ""
        
        return quantity + units + " " + name + additionalInfo
    }
}

struct Instruction: Codable, Equatable, Identifiable {
    let id: Tagged<Self, UUID>
    var text: String
}

//struct CookingSession: Codable, Equatable, Identifiable {
//    let id: Tagged<Self, UUID>
//    var date: Date
//    var notes: String
//}

//struct Step: Codable, Equatable, Identifiable {
//    let id: Tagged<Self, UUID>
//    var description: String
//    var number: String?
//}

extension Recipe {
    static let chickenCurryMock = Self(
        course: .main,
        cuisine: .indian,
        introduction: "This homemade creamy butter chicken curry tastes exactly like in your local takeout but much cheaper!",
        id: Recipe.ID(UUID()),
        ingredients: [
            Ingredient(id: Ingredient.ID(UUID()), name: "chicken breasts", additionalInfo: "cubed", quantity: "450", units: "g"),
            Ingredient(id: Ingredient.ID(UUID()), name: "tandoori masala spice mix", quantity: "4", units: "tbsp"),
            Ingredient(id: Ingredient.ID(UUID()), name: "natural yoghurt", additionalInfo: "plain", quantity: "250", units: "ml"),
            Ingredient(id: Ingredient.ID(UUID()), name: "medium onion", additionalInfo: "chopped", quantity: "1")
        ],
        instructions: [
            Instruction(id: Instruction.ID(UUID()), text: "1. In a medium bowl mix the yogurt with the tandoori masala spice mix and add cubed chicken breasts. Marinade for at least 3 hours or overnight."),
            Instruction(id: Instruction.ID(UUID()), text: "2. In a deep pan heat the ghee or oil and fry the chopped onion, garlic and ginger together over low heat for 10 minutes."),
            Instruction(id: Instruction.ID(UUID()), text: "3. Add the chicken with the marinade to the pan, add the coriander and turmeric, tomato paste and water, stir to combine, then turn the heat up to medium and bring to a boil, then lower the heat and simmer for 20 minutes covered."),
            Instruction(id: Instruction.ID(UUID()), text: "4. Add the double cream, stir and cook uncovered for 10 minutes longer until the sauce is thick and desired consistency. Add salt if needed. (There is salt in the tandoori masala spice mix, so only add extra salt if necessary.)"),
            Instruction(id: Instruction.ID(UUID()), text: "5. Serve with fresh cilantro and basmati rice.")
        ],
        source: "Vikalinka",
        time: Duration.seconds(60 * 70),
        //totalTime: "1h15min",
        title: "Butter Chicken Curry"
    )
    
    static let auberginesAndMozzarellaMock = Self(
        course: .main,
        introduction: "In this recipe the roasted aubergines are marinated post­ cooking in a dressing packed with lemon and chilli. A generous topping of marinated mozzarella adds both flavour and texture, making this the perfect addition to a vegetarian sharing feast. For a balanced meal, serve with a side of bulgur wheat.",
        id: Recipe.ID(UUID()),
        ingredients: [
            Ingredient(id: Ingredient.ID(UUID()), name: "large aubergines", quantity: "2"),
            Ingredient(id: Ingredient.ID(UUID()), name: "sea salt"),
            Ingredient(id: Ingredient.ID(UUID()), name: "extra virgin olive oil", quantity: "6", units: "tbsp"),
            Ingredient(id: Ingredient.ID(UUID()), name: "lemons", additionalInfo: "zest and juice", quantity: "2")
        ],
        instructions: [
            Instruction(id: Instruction.ID(UUID()), text:"1. Preheat the oven to 180°C fan/200°C/ gas 6. Cut the tops off the aubergines and slice them lengthways in half, then cut each half lengthways into long quarters. Place the slices in a large roasting tin in a single layer, add a generous scattering of sea salt and drizzle with the olive oil. Mix well with your hands to evenly coat the slices in the oil and salt, then pop into the oven and roast for 40 minutes."),
            Instruction(id: Instruction.ID(UUID()), text:"2. Meanwhile, whisk together the extra virgin olive oil, lemon zest and juice, flat­ leaf parsley and chilli. Season to taste with sea salt, then tip a few tablespoons of the dressing over the torn mozzarella while the aubergines are cooking."),
            Instruction(id: Instruction.ID(UUID()), text:"3. As soon as the aubergines are cooked, tip the remaining dressing over them and turn them over gently until thoroughly coated. Allow them to sit in the dressing for 5 minutes, then tip over the marinated mozzarella and serve warm."),
            Instruction(id: Instruction.ID(UUID()), text:"Note: Take the mozzarella out of the fridge 30 minutes before using and drain in a sieve.")
        ],
        source: "The Roasting Tin",
        time: Duration.seconds(60 * 40),
        //totalTime: "50min",
        title: "Roasted Aubergines with Mozzarella, Chilli, Lemon and Flat-leaf Parsley"
    )
}
