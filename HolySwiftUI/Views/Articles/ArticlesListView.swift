//
//  ArticlesListView.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 8/28/24.
//

import SwiftUI

public typealias ArticlesPagingCompletion = (Article) async -> Void

struct ArticlesListView: View {
    
    @Binding var articles: [Article]
    
    var pagingCompletion: ArticlesPagingCompletion? = nil
    
    var body: some View {
        LazyVStack {
            ForEach(articles) { article in
                NavigationLink(value: article) {
                    ArticleCellView(article: article)
                }
                Divider()
            }
        }
        .navigationDestination(for: Article.self) { article in
            ArticleDetailView(article: article)
        }
    }
}

#Preview {
    ArticlesListView(articles: .constant([.testObject, .testObject]))
}
