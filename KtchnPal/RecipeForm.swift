//
//  RecipeForm.swift
//  KtchnPal
//
//  Created by Vanya Mutafchieva on 18/11/2024.
//

import SwiftUI

@Observable
class RecipeFormModel: Identifiable {
    var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    func addIngredientButtonTapped() {
        let ingredient = Ingredient(id: Ingredient.ID(UUID()), name: "")
        recipe.ingredients.append(ingredient)
    }
    
}

struct RecipeFormView: View {
    @Bindable var model: RecipeFormModel
    
    var body: some View {
        Form {
            recipeInfo
            
            ingredients
            
        }
    }
    
    private var recipeInfo: some View {
        Section {
            TextField("Title", text: $model.recipe.title)
            TextField("Source", text: $model.recipe.source)
            CoursePicker(selection: $model.recipe.course)
            HStack {
                Slider(value: $model.recipe.time.seconds, in: 5...180, step: 5) {
                    Text("Total Time")
                }
                Spacer()
                Text(model.recipe.time.formatted(.units()))
                
            }
        } header: {
            Text("Recipe Info")
        }
    }
    
        private var ingredients: some View {
            Section {
                ForEach($model.recipe.ingredients) { $ingredient in
                    TextField("Ingredient", text: $ingredient.name)
                }
                Button("New Ingredient") {
                    model.addIngredientButtonTapped()
                }
            } header: {
                Text("Ingredients")
            }
        }
}
struct CoursePicker: View {
    @Binding var selection: Course
    
    var body: some View {
        Picker("Course", selection: $selection) {
            ForEach(Course.allCases) { course in
                //Label(course.name, systemImage: "fork.knife.circle")
                Text(course.name)
                .padding(4)
                .fixedSize(horizontal: false, vertical: true)
                .tag(course)
            }
        }
    }
}

extension Duration {
  fileprivate var seconds: Double {
    get { Double(components.seconds / 60) }
    set { self = .seconds(newValue * 60) }
  }
    fileprivate var minutes: Double {
      get { Double(components.seconds / (60 * 60)) }
      set { self = .seconds(newValue * 60 * 60) }
    }
}

#Preview {
    @Previewable @State var recipe: Recipe = .chickenCurryMock
    RecipeFormView(model: RecipeFormModel(recipe: recipe))
}
