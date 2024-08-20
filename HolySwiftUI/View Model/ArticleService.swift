//
//  ArticleService.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 8/20/24.
//

import Foundation

final class ArticleService: NSObject {
    
    private enum ArticleServiceError: Error {
        case invalidURL
        case responseFailed
        case decodingFailed
        case dataFailed
    }
    
    private let newsURL: URL? = URL(string: "https://newsapi.org/v2/everything?q=Apple&from=2024-08-20&sortBy=popularity&apiKey=84233e313323404987bcaf124b44ea6f")
    
    func fetchArticles() async throws -> [Article] {
        guard let newsURL else { throw ArticleServiceError.invalidURL }
        let request = URLRequest(url: newsURL)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw ArticleServiceError.responseFailed }
        
        do {
            let articles = try JSONDecoder().decode([Article].self, from: data)
            return articles
        } catch {
            throw ArticleServiceError.decodingFailed
        }
    }
}