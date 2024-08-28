//
//  ArticleDetailView.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 8/28/24.
//

import SwiftUI

struct ArticleDetailView: View {
    
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                imageView
                articleDescription
                    .padding(10)
            }
        }
        .navigationTitle("Article")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var imageView: some View {
        AsyncImage(url: article.urlToImage) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .frame(width: UIScreen.main.bounds.width)
                .clipped()
        } placeholder: {
            Color.gray.opacity(0.2)
        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
    }
    
    private var articleDescription: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.system(size: 28).bold())
                if let author = article.author {
                    Text(author)
                        .font(.system(size: 18))
                        .foregroundStyle(.secondary)
                }
            }
            Text(article.description)
                .font(.system(size: 22))
        }
        .multilineTextAlignment(.leading)
    }
}

#Preview {
    NavigationStack {
        ArticleDetailView(article: .testObject)
    }
}
