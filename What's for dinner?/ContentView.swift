//
//  ContentView.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = RecipesViewModel()
    @State private var searchText = ""
    @State private var showResults = false

    var body: some View {
        NavigationView {
            VStack {
                Text("What's for Dinner?")
                    .font(.custom("AvenirNext-Bold", size: 28))
                    .foregroundColor(.orange)
                    .padding(.bottom, 10)

                Text("Find the perfect recipe for your ingredients or cuisine.")
                    .font(.custom("AvenirNext-Regular", size: 18))
                    .foregroundColor(.orange)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                SearchBar(text: $searchText, onSearch: {
                    print("Search initiated for: \(searchText)")
                    viewModel.loadRecipes(for: searchText)
                    showResults = true
                })
                .padding(.bottom, 50)

                NavigationLink(destination: RecipeListView(viewModel: viewModel, category: searchText), isActive: $showResults) { EmptyView() }

                Spacer()
            }
            .background(Color.blue)
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
        TextField("Enter a protein, ingredient, or cuisine...", text: $text)
            .padding(12)
            .background(Color.white)
            .foregroundColor(Color.orange)
            .accentColor(Color.orange)
            .cornerRadius(10)
            .padding(.horizontal)
            .onSubmit { onSearch() }
    }
}


