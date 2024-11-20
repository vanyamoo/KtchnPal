//
//  RecipeDetail.swift
//  KtchnPal
//
//  Created by Vanya Mutafchieva on 15/11/2024.
//

import SwiftUI
import SwiftUINavigation

@Observable
class RecipeDetailModel {
    var destination: Destination?
    var recipe: Recipe
    
    @CasePathable
    enum Destination {
        case edit(RecipeFormModel)
    }
    
    init(destination: Destination? = nil, recipe: Recipe) {
        self.destination = destination
        self.recipe = recipe
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
