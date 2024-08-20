//
//  NewsSource.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 8/20/24.
//

import Foundation

public struct Article: Codable {
    let source: Source
    let author: String
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
} 
