//
//  RecipesList.swift
//  KtchnPal
//
//  Created by Vanya Mutafchieva on 14/11/2024.
//

import IdentifiedCollections
import SwiftUI
import SwiftUINavigation

@Observable
class RecipesListModel {
    var destination: Destination?
    var recipes: IdentifiedArrayOf<Recipe>
    
    @CasePathable
    enum Destination {
        case add(RecipeFormModel)
        case detail(RecipeDetailModel)
    }
    
    init(destination: Destination? = nil, recipes: IdentifiedArrayOf<Recipe>) {
        self.destination = destination
        self.recipes = recipes
    }
    
    func addRecipeButtonTapped() {
        destination = .add(RecipeFormModel(recipe: Recipe(id: Recipe.ID(UUID()))))
    }
    
    func confirmAddRecipeButtonTapped() {
        defer { destination = nil } // no matter what happened we'll clear the sheet
        //if let destination {
        //    switch destination {
        //    case let .add(recipeFormModel):
        //        recipes.append(recipeFormModel.recipe)
        //    }
        //}
        guard case let .add(recipeFormModel) = destination else { return }
        var newRecipe = recipeFormModel.recipe
        
        // remove ingredients with empty names
        newRecipe.ingredients.removeAll { ingredient in
            ingredient.name.allSatisfy(\.isWhitespace)
        }
        if newRecipe.ingredients.isEmpty {
            newRecipe.ingredients.append(Ingredient(id: Ingredient.ID(UUID()), name: ""))
        }
        recipes.append(newRecipe)
    }
    
    func dismissAddRecipeButtonTapped() {
        destination = nil
    }
    
    func recipeTapped(recipe: Recipe) {
        destination = .detail(RecipeDetailModel(recipe: recipe))
    }
}

struct RecipesList: View {
    @Bindable var model: RecipesListModel
    
    var body: some View {
        NavigationStack {
            List(model.recipes) { recipe in
                Button {
                    model.recipeTapped(recipe: recipe)
                } label: {
                    RecipeCardView(recipe: recipe)
                }
                //.listRowBackground(syncup.theme.mainColor)
                
            }
            .navigationTitle("Recipes")
            .toolbar {
                Button {
                    model.addRecipeButtonTapped()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .navigationDestination(item: $model.destination.detail) { $detailModel in
                RecipeDetailView(model: detailModel)
            }
            .sheet(item: $model.destination.add) { addModel in
                NavigationStack {
                    RecipeFormView(model: addModel)
                        .navigationTitle("New Recipe")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    model.dismissAddRecipeButtonTapped()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    model.confirmAddRecipeButtonTapped()
                                }
                            }
                        }
                }
            }
        }
        
        
        
    }
}

struct RecipeCardView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            //Text("\(recipe.title)\n") // makes it span two lines
            Text(recipe.title)
                .foregroundStyle(.black)
                .font(.headline)
                .lineLimit(2)
            
            HStack {
                Text(recipe.source)
                Spacer()
                time
            }
            .font(.callout)
            //.foregroundStyle(.secondary)
            .foregroundStyle(.gray)
        }
    }
    
    private var time: some View {
        HStack(spacing: 4) {
            Image(systemName: "clock")
                .foregroundColor(.secondary)
            
            Text(recipe.time.formatted(.units()))
        }
        .font(.caption)
    }
}

#Preview {
    NavigationStack {
        RecipesList(
            model: RecipesListModel(
                recipes: [
                    .chickenCurryMock,
                    .auberginesAndMozzarellaMock
                ])
        )
    }
}
