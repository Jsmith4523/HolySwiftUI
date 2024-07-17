//
//  ContentView.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 5/4/24.
//

import SwiftUI

private enum ContentTabViewSelection: String, Hashable {
	case home   = "Home"
	case search = "Search"
}

struct ContentView: View {
	
	@State private var selection: ContentTabViewSelection = .home
	
    var body: some View {
		TabView(selection: $selection) {
			TestContentView(title: ContentTabViewSelection.home.rawValue)
				.tag(ContentTabViewSelection.home)
				.tabItem {
					Label(ContentTabViewSelection.home.rawValue, systemImage: "house")
				}
			TestContentView(title:  ContentTabViewSelection.search.rawValue)
				.tag(ContentTabViewSelection.search)
				.tabItem {
					Label(ContentTabViewSelection.search.rawValue, systemImage: "star")
				}
		}
    }
}

struct TestContentView: View {
	
	let title: String
	
	var body: some View {
		NavigationStack {
			ZStack(alignment: .bottomTrailing)  {
				VStack {
					NavigationLink("Go Somewhere") {
						TestPushContentView()
					}
				}
				.frame(maxWidth: .infinity)
				.frame(maxHeight: .infinity)
				Button {
					
				} label: {
					Image(systemName: "plus")
						.padding()
						.font(.system(size: 22))
						.foregroundStyle(.white)
						.frame(width: 50, height: 50)
						.background(Color.blue)
						.clipShape(Circle())
						.padding()
				}
				.additionalSafeAreaInsetModifier(inset: UIEdgeInsets(top: 0, left: 0, bottom: 52, right: 0))
			}
			.navigationTitle(title)
		}
	}
	
	struct TestPushContentView: View {
		
		var body: some View {
			NavigationLink("AGAIN!") {
				TestPushContentView()
			}
		}
	}
}

#Preview {
    ContentView()
}
