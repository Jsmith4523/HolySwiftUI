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
    case profile    = "Profile"
    
    @ViewBuilder var label: some View {
        switch self {
        case .articles:
            Label("Articles", systemImage: "newspaper")
        case .search:
            Label("Search", systemImage: "magnifyingglass")
        case .profile:
            Label("Profile", systemImage: "person")
        }
    }
    
    var symbol: String {
        switch self {
        case .articles:
            return "newspaper"
        case .search:
            return "magnifyingglass"
        case .profile:
            return "person"
        }
    }
}
