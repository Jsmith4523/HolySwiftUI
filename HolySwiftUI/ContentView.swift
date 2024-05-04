//
//  ContentView.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 5/4/24.
//

import SwiftUI

enum ContentTabViewSelection: String, Hashable {
	case home   = "Home"
	case search = "Search"
}

struct ContentView: View {
	
	@State private var selection: ContentTabViewSelection = .home
	
    var body: some View {
		TabView(selection: binding) {
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

struct TestContentView: View {
	
	enum Destinations: CaseIterable, Identifiable, Hashable {
		case detailView, profileView
		var id: Self { self }
		
		var title: String {
			switch self {
			case .detailView:
				return "Detail View"
			case .profileView:
				return "Profile View"
			}
		}
	}
	
	@State private var path = NavigationPath()
	
	let title: String
	
	var body: some View {
		NavigationStack(path: $path) {
			TabViewItemWrapperView(path: $path, selection: .home) {
				VStack {
					ForEach(Destinations.allCases) { destination in
						NavigationLink(value: destination) {
							Text(destination.title)
						}
					}
				}
				.navigationTitle(title)
				.navigationDestination(for: Destinations.self) { destination in
					switch destination {
					case .detailView:
						Text("Detail View Example")
							.font(.system(size: 19))
						ForEach(Destinations.allCases) { destination in
							NavigationLink(value: destination) {
								Text(destination.title)
							}
						}
					case .profileView:
						Text("Profile View Example")
							.font(.system(size: 19))
						ForEach(Destinations.allCases) { destination in
							NavigationLink(value: destination) {
								Text(destination.title)
							}
						}
					}
				}
			}
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
