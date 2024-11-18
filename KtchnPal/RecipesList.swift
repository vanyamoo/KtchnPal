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
                    //model.addRecipeButtonTapped()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .navigationDestination(item: $model.destination.detail) { $detailModel in
                RecipeDetailView(model: detailModel)
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
            
            Text(recipe.totalTime)
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
