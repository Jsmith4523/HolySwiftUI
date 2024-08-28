//
//  ArticleSearchView.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 8/28/24.
//

import SwiftUI

struct ArticleSearchView: View {
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
//            TabViewItemWrapperView(path: $path, selection: .search) {
//                VStack {
//                    
//                }
//            }
        }
    }
}

#Preview {
    ArticleSearchView()
}
