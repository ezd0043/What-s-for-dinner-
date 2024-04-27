//
//  RecipeService.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//

import Combine
import SwiftUI
import Foundation

struct RecipeService {
    let apiKey = "576df50975404f929fbcb71e61b60a2e"
    
    // Fetch a list of recipe summaries
    func fetchRecipes(category: String) -> AnyPublisher<[Recipe], Error> {
        let encodedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?query=\(encodedCategory)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { response in
                guard let httpResponse = response.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return response.data
            }
            .decode(type: RecipeResults.self, decoder: JSONDecoder())
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // Fetch a single recipe detail by its ID
    func fetchRecipeDetail(recipeId: Int) -> AnyPublisher<Recipe, Error> {
        let detailUrlString = "https://api.spoonacular.com/recipes/\(recipeId)/information?includeNutrition=false&apiKey=\(apiKey)"
        guard let detailUrl = URL(string: detailUrlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: detailUrl)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                if !(200...299).contains(httpResponse.statusCode) {
                    throw URLError(URLError.Code(rawValue: httpResponse.statusCode))
                }
                return data
            }
            .decode(type: Recipe.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

