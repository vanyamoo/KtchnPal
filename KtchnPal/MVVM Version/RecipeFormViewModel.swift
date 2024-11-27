//
//  RecipeFormViewModel.swift
//  KtchnPal
//
//  Created by Vanya Mutafchieva on 26/11/2024.
//

import SwiftUI

@Observable
class RecipeFormViewModel {
    var recipe: Recipe
    var focus: RecipeFormView.Field?
    
    init(focus: RecipeFormView.Field? = .title, recipe: Recipe) {
        self.focus = focus
        self.recipe = recipe
        
        if recipe.ingredients.isEmpty {
            self.recipe.ingredients.append(Ingredient(id: Ingredient.ID(UUID()), name: ""))
        }
        if recipe.instructions.isEmpty {
            self.recipe.instructions.append(Instruction(id: Instruction.ID(UUID()), text: ""))
        }
    }
    
    func addIngredientButtonTapped() {
        let ingredient = Ingredient(id: Ingredient.ID(UUID()), name: "")
        recipe.ingredients.append(ingredient)
        focus = .ingredient(ingredient.id)
    }
    
    func deleteIngrediends(atOffsets indices: IndexSet) {
        recipe.ingredients.remove(atOffsets: indices)
        if recipe.ingredients.isEmpty {
            recipe.ingredients.append(Ingredient(id: Ingredient.ID(UUID()), name: ""))
        }
        let index = min(indices.first!, recipe.ingredients.count - 1)
        focus = .ingredient(recipe.ingredients[index].id)
    }
    
    func deleteInstructions(atOffsets indices: IndexSet) {
        recipe.instructions.remove(atOffsets: indices)
        if recipe.instructions.isEmpty {
            recipe.instructions.append(Instruction(id: Instruction.ID(UUID()), text: ""))
        }
        let index = min(indices.first!, recipe.instructions.count - 1)
        focus = .instruction(recipe.instructions[index].id)
    }
    
    func nextStepButtonTapped() {
        let instruction = Instruction(id: Instruction.ID(UUID()), text: "")
        recipe.instructions.append(instruction)
        focus = .instruction(instruction.id)
    }
}
