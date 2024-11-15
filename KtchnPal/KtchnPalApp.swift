//
//  KtchnPalApp.swift
//  KtchnPal
//
//  Created by Vanya Mutafchieva on 14/11/2024.
//

import SwiftUI

@main
struct KtchnPalApp: App {
    var body: some Scene {
        WindowGroup {
            RecipesList(
                model: RecipesListModel(
                    recipes: [
                        .chickenCurryMock,
                        .auberginesAndMozzarellaMock
                    ])
            )
        }
    }
}
