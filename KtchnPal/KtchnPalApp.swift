//
//  KtchnPalApp.swift
//  KtchnPal
//
//  Created by Vanya Mutafchieva on 14/11/2024.
//

import SwiftUI

@main
struct KtchnPalApp: App {
    static let model = AppModel(recipesListModel: RecipesListModel(
                            recipes: [
                                .chickenCurryMock,
                                .auberginesAndMozzarellaMock
                            ]))
  
    var body: some Scene {
        WindowGroup {
            AppView(model: Self.model)
        }
    }

//    var body: some Scene {
//        WindowGroup {
//            RecipesList(
//                model: RecipesListModel(
//                    recipes: [
//                        .chickenCurryMock,
//                        .auberginesAndMozzarellaMock
//                    ])
//            )
//        }
//    }
}
