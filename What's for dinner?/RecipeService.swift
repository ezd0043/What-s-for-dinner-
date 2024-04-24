//
//  RecipeService.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//
import Combine
import Foundation

struct RecipeService {
    let apiKey = "576df50975404f929fbcb71e61b60a2e" 

    func fetchRecipes(category: String) -> AnyPublisher<[Recipe], Error> {
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?query=\(category)&apiKey=\(apiKey)"
        
        print("Attempting to fetch recipes for category: \(category)")

        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    let httpResponse = output.response as? HTTPURLResponse
                    throw URLError(.badServerResponse, userInfo: [
                        NSLocalizedDescriptionKey: "Bad server response: \(httpResponse?.statusCode ?? 0)"
                    ])
                }
                return output.data
            }
            .handleEvents(receiveSubscription: { _ in
                print("Subscription received for URL: \(urlString)")
            }, receiveOutput: { _ in
                print("Data received from API.")
            }, receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error received from API: \(error)")
                }
            }, receiveCancel: {
                print("API request cancelled.")
            })
            .decode(type: RecipeResults.self, decoder: JSONDecoder())
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct RecipeResults: Codable {
    let results: [Recipe]
}
