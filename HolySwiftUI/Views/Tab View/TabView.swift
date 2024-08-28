//
//  ContentView.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 5/4/24.
//

import SwiftUI

struct ContentView: View {
	
    @State private var selection: ContentTabViewSelection = .articles
	
    var body: some View {
		TabView(selection: binding) {
            ArticlesView()
                .tag(ContentTabViewSelection.articles)
				.tabItem {
                    ContentTabViewSelection.articles.label
				}
            ArticleSearchView()
				.tag(ContentTabViewSelection.search)
				.tabItem {
                    ContentTabViewSelection.search.label
				}
		}
        .tint(.primary)
    }
	
	var binding: Binding<ContentTabViewSelection> {
		return .init {
			return selection
		} set: { selection in
			if selection == self.selection {
				NotificationCenter.default.postTabViewItemDidChange(selection)
			}
			self.selection = selection
		}
	}
}


#Preview {
    ContentView()
}
