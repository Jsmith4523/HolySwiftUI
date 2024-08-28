//
//  NewsSource.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 8/20/24.
//

import Foundation

public struct Article: Decodable, Identifiable {
    public var id: UUID
    
    let source: Article.Source
    let author: String?
    let title: String
    let description: String
    let url: URL
    let urlToImage: URL?
    let publishedAt: String
    let content: String
    
    struct Source: Codable {
        let id: String?
        let name: String?
    }
    
    init(source: Article.Source, author: String?, title: String, description: String, url: URL, urlToImage: URL?, publishedAt: String, content: String) {
        self.id = UUID()
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.source = try container.decode(Article.Source.self, forKey: .source)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.url = try container.decode(URL.self, forKey: .url)
        self.urlToImage = try container.decodeIfPresent(URL.self, forKey: .urlToImage)
        self.publishedAt = try container.decode(String.self, forKey: .publishedAt)
        self.content = try container.decode(String.self, forKey: .content)
    }
    
    enum CodingKeys: CodingKey {
        case id
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
    
    static var testObject: Article {
        return .init(source: .init(id: "12345", name: "MLK"), author: "Martin Luther King Jr.", title: "I Have a Dream", description: "I had a dream that one day this nation would be able to rise up and live out the true meaning of its creed: 'Equal opportunity for all.'", url: URL(string: "https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://unsplash.com/s/photos/martin-luther-king&ved=2ahUKEwjL1dbmnZiIAxX_GVkFHdknGFAQFnoECCIQAQ&usg=AOvVaw2m9_o8xmij4QmxAZ70qcH5")!, urlToImage: URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/05/Martin_Luther_King%2C_Jr..jpg")!, publishedAt: "Times Square", content: "")
    }
}
