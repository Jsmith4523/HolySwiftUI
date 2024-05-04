//
//  ContentView.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 5/4/24.
//

import SwiftUI

//MARK: 1) Creating Your Tab View Selection Enums
private enum ContentTabViewSelection: String, Hashable {
	case home   = "Home"
	case search = "Search"
}

struct ContentView: View {
	
//MARK: 2) Create Your State Property
	@State private var selection: ContentTabViewSelection = .home
	
    var body: some View {
		TabView(selection: tabViewSelection) {
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
	
	private var tabViewSelection: Binding<ContentTabViewSelection> {
		return .init {
			return selection
		} set: { newSelection in
			//MARK: 9) Comparing binding values...
			if newSelection == self.selection {
				UITabBarController.popNavigationController(for: selection)
			}
			self.selection = newSelection
		}
	}
}


//MARK: 5) Creating an extension to UITabBarController
extension UITabBarController {
	
	//MARK: 6) Create a static set of navigation controllers with their tab view selection
	static private var tabViewSelections = Set<[ContentTabViewSelection: UINavigationController]>()
//
	//MARK: 7) Inserting the UINavigationController with their tab view selection
	static fileprivate func addTabViewSelection(_ value: [ContentTabViewSelection: UINavigationController]) {
		tabViewSelections.insert(value)
	}
//	
	//MARK: 8) Pop the Navigation Controller based upon its tab view selection
	static fileprivate func popNavigationController(for tabViewSelection: ContentTabViewSelection) {
		if let navigationController = (tabViewSelections.first(where: {$0.keys.contains(where: {$0 == tabViewSelection})}))?.values.first {
			navigationController.popToRootViewController(animated: true)
		}
	}
}

//MARK: 3) Creating an extension to UINavigationController
extension UINavigationController {
	
	open override func viewLayoutMarginsDidChange() {
		super.viewLayoutMarginsDidChange()
		//MARK: 4) Find the navigation title through the navigation bar items
		if let items = navigationBar.items {
			let tabViewSelection = items
				.compactMap({$0.title})
				.compactMap({ContentTabViewSelection(rawValue: $0)})
				.first
			
			if let tabViewSelection {
				let dictionary: [ContentTabViewSelection: UINavigationController] = [tabViewSelection: self]
				UITabBarController.addTabViewSelection(dictionary)
			}
		}
	}
}

struct TestContentView: View {
	
	let title: String
	
	var body: some View {
		NavigationStack {
			VStack {
				NavigationLink("Go Somewhere") {
					TestPushContentView()
				}
			}
			//MARK: 2 1/2) Set a SwiftUI Navigation Title (display mode does not matter!)
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
