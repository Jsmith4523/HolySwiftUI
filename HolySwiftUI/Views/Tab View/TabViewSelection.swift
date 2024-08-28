//
//  TabViewSelection.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 8/28/24.
//

import Foundation
import SwiftUI

enum ContentTabViewSelection: String, Hashable {
    case articles   = "Articles"
    case search     = "Search"
    
    @ViewBuilder var label: some View {
        switch self {
        case .articles:
            Label("Articles", systemImage: "newspaper")
        case .search:
            Label("Search", systemImage: "magnifyingglass")
        }
    }
}
