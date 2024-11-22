//
//  RecipeDetail.swift
//  KtchnPal
//
//  Created by Vanya Mutafchieva on 15/11/2024.
//

import IssueReporting
import SwiftUI
import SwiftUINavigation

@Observable
class RecipeDetailModel {
    var destination: Destination?
    var recipe: Recipe {
        didSet {
            onRecipeUpdated(recipe)
        }
    }
    var onConfirmDeletion: () -> Void = unimplemented("RecipeDetailModel.onConfirmDeletion")
    var onRecipeUpdated: (Recipe) -> Void = unimplemented("RecipeDetailModel.onRecipeUpdated")
    
    @CasePathable
    enum Destination {
        case alert(AlertState<AlertAction>)
        case edit(RecipeFormModel)
    }
    
    enum AlertAction {
        case confirmDeletion
    }
    
    init(destination: Destination? = nil, recipe: Recipe) {
        self.destination = destination
        self.recipe = recipe
    }
    
    func alertButtonTapped(_ action: AlertAction) {
        switch action {
        case .confirmDeletion:
            onConfirmDeletion()
        }
    }
    
    func cancelEditButtonTapped() {
        destination = nil
    }
    
    func deleteButtonTapped() {
        destination = .alert(.deleteRecipe)
    }
    
    func doneEdittingButtonTapped() {
        guard case let .edit(editModel) = destination else { return }
        recipe = editModel.recipe
        destination = nil
    }
    
    func editButtonTapped() {
        destination = .edit(RecipeFormModel(recipe: recipe))
    }
}

struct RecipeDetailView: View {
    @Bindable var model: RecipeDetailModel
    
    var body: some View {
        List {
            recipeInfo
            
            ingredients
            
            method
            
            //pastCookingSessions
            
            delete
        }
        .navigationTitle(model.recipe.title)
        .toolbar {
            Button("Edit") {
                model.editButtonTapped()
            }
        }
        .alert($model.destination.alert, action: { action in
            guard let action else { return }
            //if let action {
                model.alertButtonTapped(action)
            //}
        })
        .sheet(item: $model.destination.edit) { $editModel in
            NavigationStack {
                RecipeFormView(model: editModel)
                    .navigationTitle(editModel.recipe.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                model.cancelEditButtonTapped()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                model.doneEdittingButtonTapped()
                            }
                        }
                    }
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
            HStack {
                Label("Course", systemImage: "fork.knife")
                Spacer()
                Text(model.recipe.course.rawValue.capitalized)
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
                Text(ingredient.nameFormatted)
                
            }
        } header: {
            Text("Ingredients")
        }
    }
    
//    @ViewBuilder
//    private var pastCookingSessions: some View {
//        if !model.recipe.pastCookingSessions.isEmpty {
//            Section {
//                ForEach(model.recipe.pastCookingSessions) { session in
//                    Button {
//                        //model.sessionTapped(session)
//                    } label: {
//                        HStack {
//                            Image(systemName: "calendar")
//                            Text(session.date, style: .date)
//                            Text(session.date, style: .time)
//                        }
//                    }
//                }
//                .onDelete { indices in
//                    //model.deleteSessions(atOffsets: indices)
//                }
//            } header: {
//                Text("Notes from past cooking sessions")
//            }
//        }
//    }
    
    private var method: some View {
        Section {
            ForEach(model.recipe.instructions) { instruction in
                Text(instruction.text)
                
            }
        } header: {
            Text("Method")
        }
    }
    
    private var delete: some View {
        Section {
            Button("Delete") {
                model.deleteButtonTapped()
            }
            .foregroundColor(.red)
            .frame(maxWidth: .infinity)
        }
    }
    

}

extension AlertState where Action == RecipeDetailModel.AlertAction {
    static let deleteRecipe = Self {
        TextState("Delete?")
    } actions: {
        ButtonState(role: .destructive, action: .confirmDeletion) {
            TextState("Yes")
        }
        ButtonState(role: .cancel) {
            TextState("Nevermind")
        }
    } message: {
        TextState("Are you sure you want to delete this recipe?")
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(model: RecipeDetailModel(recipe: .chickenCurryMock))
    }
    
}
