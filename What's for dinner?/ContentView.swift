//
//  ContentView.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//
import SwiftUI

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = RecipesViewModel()
    @State private var searchText = ""
    @State private var showResults = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                Image("Cheers")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                Text("What's for Dinner?")
                    .font(.custom("AvenirNext-Bold", size: 28))
                    .foregroundColor(Color.red)
                
                Text("We help you decide what to cook for dinner!")
                    .font(.custom("AvenirNext-Regular", size: 18))
                    .foregroundColor(Color.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                SearchBar(text: $searchText, onSearch: {
                    print("Search initiated for: \(searchText)")
                    viewModel.loadRecipes(for: searchText)
                    showResults = true
                })
                
                NavigationLink(destination: RecipeListView(viewModel: viewModel, category: searchText), isActive: $showResults) { EmptyView() }

                Spacer()
            }
            .background(Color.orange)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// Search Bar
struct SearchBar: View {
    @Binding var text: String
    let onSearch: () -> Void
    
    var body: some View {
        TextField("Enter a dish, ingredient, cuisine, or cocktail...", text: $text)
            .padding(12)
            .background(Color.orange)
            .foregroundColor(Color.red)
            .cornerRadius(10)
            .padding(.horizontal)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.red, lineWidth: 2)
            )
            .onSubmit { onSearch() }
    }
}
