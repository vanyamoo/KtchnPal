//
//  RecipesListViewModel.swift
//  KtchnPal
//
//  Created by Vanya Mutafchieva on 26/11/2024.
//

import IdentifiedCollections
import SwiftUI
import SwiftUINavigation


@Observable
class RecipesListViewModel {
    var destination: Destination?
    
    @CasePathable
    enum Destination {
        //case add(RecipeFormModel)
        case detail(RecipeDetailViewModel)
    }
    
    var recipes: IdentifiedArrayOf<Recipe>
    
    
    init(destination: Destination? = nil, recipes: IdentifiedArrayOf<Recipe>) {
        self.destination = destination
        self.recipes = recipes
    }
    
// MARK: Intents -
    
    func addRecipeButtonTapped() {
        
    }
    
    func recipeTapped(recipe: Recipe) {
        destination = .detail(RecipeDetailViewModel(recipe: recipe))
    }
}
