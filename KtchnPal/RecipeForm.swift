//
//  RecipeForm.swift
//  KtchnPal
//
//  Created by Vanya Mutafchieva on 18/11/2024.
//

import SwiftUI
import SwiftUINavigation

@Observable
class RecipeFormModel: Identifiable {
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

struct RecipeFormView: View {
    @Bindable var model: RecipeFormModel
    
    enum Field: Hashable {
        case ingredient(Ingredient.ID)
        case instruction(Instruction.ID)
        case source
        case title
    }
    
    @FocusState var focus: Field?
    
    var body: some View {
        Form {
            recipeInfo
            
            ingredients
            
            method
            
        }
        .bind($model.focus, to: $focus) // we bind the model's focus to the View's focus
    }
    
    private var recipeInfo: some View {
        Section {
            TextField("Title", text: $model.recipe.title)
                .focused($focus, equals: .title)
            TextField("Source", text: $model.recipe.source)
                .focused($focus, equals: .source)
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
                TextField(Constants.Ingredients.example[model.recipe.ingredients.count - 1].nameFormatted, text: $ingredient.name)
                //TextField("450g chicken breasts, diced", text: $ingredient.name)
                    .focused($focus, equals: .ingredient(ingredient.id))
            }
            .onDelete { indices in
                model.deleteIngrediends(atOffsets: indices)
            }
            Button("New ingredient") {
                model.addIngredientButtonTapped()
            }
        } header: {
            Text("Ingredients")
        }
    }
    
    private var method: some View {
        Section {
            ForEach($model.recipe.instructions) { $instruction in
                TextField("\(model.recipe.instructions.count). ...", text: $instruction.text)
                    .focused($focus, equals: .instruction(instruction.id))
            }
            .onDelete { indices in
                model.deleteInstructions(atOffsets: indices)
            }
            Button("Next step") {
                model.nextStepButtonTapped()
            }
        } header: {
            Text("Method")
        }

    }
    
    private struct Constants {
        //static let cornerRadius: CGFloat = 12
        //static let lineWidth: CGFloat = 2
        //static let inset: CGFloat = 5
        struct Ingredients {
            static let example = [
                Ingredient(id: Ingredient.ID(UUID()), name: "chicken breasts", additionalInfo: "cubed", quantity: "450", units: "g"),
                Ingredient(id: Ingredient.ID(UUID()), name: "tandoori masala spice mix", quantity: "4", units: "tbsp"),
                Ingredient(id: Ingredient.ID(UUID()), name: "natural yoghurt", additionalInfo: "plain", quantity: "250", units: "ml"),
                Ingredient(id: Ingredient.ID(UUID()), name: "medium onion", additionalInfo: "chopped", quantity: "1")
            ]
            //static let smallest: CGFloat = 10
            //static let scaleFactor = smallest / largest
        }
        //struct Pie {
        //    static let opacity: CGFloat = 0.5
        //    static let inset: CGFloat = 5
        //}
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
}

#Preview {
    @Previewable @State var recipe: Recipe = .chickenCurryMock
    RecipeFormView(model: RecipeFormModel(recipe: recipe))
}
