//
//  RecipeDetail.swift
//  KtchnPal
//
//  Created by Vanya Mutafchieva on 15/11/2024.
//

import SwiftUI

@Observable
class RecipeDetailModel {
    var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}

struct RecipeDetailView: View {
    let model: RecipeDetailModel
    
    var body: some View {
        List {
            recipeInfo
            
            ingredients
            
            //pastCookingSessions
            
            delete
        }
        .navigationTitle(model.recipe.title)
        .toolbar {
            Button("Edit") {
                //model.editButtonTapped()
            }
        }
    }
    
    private var recipeInfo: some View {
        Section {
            //Text(model.recipe.introduction)
            Button {
                //model.startCookingButtonTapped()
            } label: {
                Label("Start Cooking", systemImage: "timer")
                    .font(.headline)
                    .foregroundColor(.accentColor)
            }
            HStack {
                Label("Source", systemImage: "book") // text.book.closed
                Spacer()
                Text(model.recipe.source)
            }
            if model.recipe.course != nil {
                HStack {
                    Label("Course", systemImage: "fork.knife")
                    Spacer()
                    Text(model.recipe.course!.rawValue.capitalized)
                }
            }
            HStack {
                Label("Total time", systemImage: "clock")
                Spacer()
                Text(model.recipe.time.formatted(.units()))
            }
        } header: {
            Text("Recipe Info")
        }
    }
    
    private var ingredients: some View {
        Section {
            ForEach(model.recipe.ingredients) { ingredient in
                Text(ingredient.description)
                
            }
        } header: {
            Text("Ingredients")
        }
    }
    
    private var delete: some View {
        Section {
            Button("Delete") {
                //model.deleteButtonTapped()
            }
            .foregroundColor(.red)
            .frame(maxWidth: .infinity)
        }
    }
    

}

#Preview {
    NavigationStack {
        RecipeDetailView(model: RecipeDetailModel(recipe: .chickenCurryMock))
    }
    
}
