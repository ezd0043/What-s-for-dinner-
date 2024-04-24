//
//  ContentView.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("What's for Dinner?")
                    .font(.largeTitle)
                    .padding()
                Text("The app for when you can't decide what to make.")
                    .font(.subheadline)
                    .padding()

                List {
                    ForEach(["Chicken", "Beef", "Seafood", "Vegetarian", "Vegan"], id: \.self) { category in
                        NavigationLink(category, destination: RecipeListView(category: category))
                    }
                }
            }
            .navigationTitle("")
        }
    }
}
