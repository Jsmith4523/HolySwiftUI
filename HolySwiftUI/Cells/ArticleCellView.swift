//
//  ArticleCellView.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 8/28/24.
//

import SwiftUI

struct ArticleCellView: View {
    
    let article: Article
    
    var body: some View {
        HStack {
            imageView
            articleDescription
        }
        .background(Color(uiColor: .systemBackground))
    }
    
    private var imageView: some View {
        AsyncImage(url: article.urlToImage) { image in
            image.resizable().scaledToFill()
        } placeholder: {
            Color.gray.opacity(0.2)
        }
        .frame(width: 65, height: 65)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
    private var articleDescription: some View {
        VStack(alignment: .leading) {
            if let author = article.author {
                Text(author)
                    .font(.caption)
            }
            Text(article.title)
                .font(.headline)
            Text(article.description)
                .font(.subheadline)
                .lineLimit(3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ArticleCellView(article: .testObject)
}
