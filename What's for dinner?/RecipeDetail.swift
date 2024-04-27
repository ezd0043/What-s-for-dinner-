//
//  RecipeDetail.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/26/24.
//
import Foundation
import Combine

class RecipeDetail: ObservableObject, Identifiable, Codable {
    @Published var id: Int
    @Published var title: String
    @Published var image: String
    @Published var instructions: String?
    var ingredients: [Ingredient]?

    enum CodingKeys: CodingKey {
        case id, title, image, instructions
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
        instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(image, forKey: .image)
        try container.encode(instructions, forKey: .instructions)
    }

    init(id: Int, title: String, image: String, instructions: String?, ingredients: [Ingredient]?) {
        self.id = id
        self.title = title
        self.image = image
        self.instructions = instructions
        self.ingredients = ingredients
    }

    struct Ingredient: Identifiable, Codable {
        let id: UUID = UUID()
        let name: String
        let amount: Double
        let unit: String
    }
}


