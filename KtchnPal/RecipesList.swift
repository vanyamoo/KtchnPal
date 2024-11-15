//
//  RecipesList.swift
//  KtchnPal
//
//  Created by Vanya Mutafchieva on 14/11/2024.
//

import IdentifiedCollections
import SwiftUI

@Observable
class RecipesListModel {
    var recipes: IdentifiedArrayOf<Recipe>
    
    init(recipes: IdentifiedArrayOf<Recipe>) {
        self.recipes = recipes
    }
}

struct RecipesList: View {
    let model: RecipesListModel
    
    var body: some View {
        NavigationStack {
            List(model.recipes) { recipe in
                RecipeCardView(recipe: recipe)
            }
        }
        .toolbar {
            Button {
                //model.addRecipeButtonTapped()
            } label: {
                Image(systemName: "plus")
            }
        }
        .navigationTitle("Recipes")
    }
}

struct RecipeCardView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            //Text("\(recipe.title)\n") // makes it span two lines
            Text(recipe.title)
                .font(.headline)
                .lineLimit(2)
            
            HStack {
                Text(recipe.source)
                Spacer()
                time
            }
            .font(.callout)
            .foregroundStyle(.secondary)
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
