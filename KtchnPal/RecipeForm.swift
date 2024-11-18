//
//  RecipeForm.swift
//  KtchnPal
//
//  Created by Vanya Mutafchieva on 18/11/2024.
//

import SwiftUI

@Observable
class RecipeFormModel {
    var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
}

struct RecipeFormView: View {
    @Bindable var model: RecipeFormModel
    
    var body: some View {
        Text("Recipe Form View")
    }
}
