//
//  RecipeDetailViewModel.swift
//  KtchnPal
//
//  Created by Vanya Mutafchieva on 26/11/2024.
//

import SwiftUI
import SwiftUINavigation

@Observable
class RecipeDetailViewModel {
    var destination: Destination?
    
    @CasePathable
    enum Destination {
        //case alert(AlertState<AlertAction>)
        case edit(RecipeFormModel)
    }
    
    var recipe: Recipe
    
    init(destination: Destination? = nil, recipe: Recipe) {
        self.destination = destination
        self.recipe = recipe
    }
}
