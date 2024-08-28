//
//  ArticlesView.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 8/28/24.
//

import SwiftUI

struct ArticlesView: View {
    
    @State private var loadState: ArticlesLoadState = .loading
    @State private var articles: [Article] = []
    
    @State private var path = NavigationPath()
    
    @StateObject private var articlesVM = ArticleViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            TabViewItemWrapperView(path: $path, selection: .articles) {
                ScrollView {
                    switch loadState {
                    case .loading:
                        ProgressView().task(fetchArticles)
                    case .loaded:
                        ArticlesListView(articles: $articles)
                    case .empty:
                        //Project target is set to 17.0 for these views...
                        ContentUnavailableView("There are no articles yet.", systemImage: "newspaper").padding()
                    case .error:
                        ContentUnavailableView("Something went wrong. Please try again", systemImage: "exclamationmark.triangle")
                    }
                }
                .refreshable(action: fetchArticles)
                .navigationTitle("Articles")
                .navigationBarTitleDisplayMode(.inline)
                .onReceive(articlesVM.$articles) { articles in
                    DispatchQueue.main.async {
                        self.articles = articles
                    }
                }
            }
        }
    }
    
    @MainActor @Sendable private func fetchArticles() async {
        do {
            try await articlesVM.fetchArticles()
            self.loadState = .loaded
        } catch {
            print(error)
            if articles.isEmpty {
                self.loadState = .error
            }
        }
    }
}

#Preview {
    ArticlesView()
}
