//
//  ArticleViewModel.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 8/20/24.
//

import Foundation
import Combine

class ArticleViewModel: ObservableObject {
    
    @Published private(set) var articles: [Article] = []
    
    private let articleService = ArticleService()
    
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchArticles() async throws {
        let articles = try await articleService.fetchArticles()
        DispatchQueue.main.async { [weak self] in
            let filteredArticles = articles.filter({$0.title != "[Removed]"})
            self?.articles = filteredArticles.shuffled()
        }
    }
}
 
