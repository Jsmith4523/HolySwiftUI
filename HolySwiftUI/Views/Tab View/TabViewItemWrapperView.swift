//
//  TabViewItemWrapperView.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 7/18/24.
//

import SwiftUI

struct TabViewItemWrapperView<C: View>: View {
	
	@Binding var path: NavigationPath
	
	let selection: ContentTabViewSelection
	var view: () -> C
	
    var body: some View {
        view()
			.onReceive(NotificationCenter.default.publisher(for: .tabViewItemDidChange)) { notification in
				if let selection = notification.object as? ContentTabViewSelection, self.selection == selection {
					if !(path.isEmpty) {
						path = .init()
					}
				}
			}
    }
}

extension NotificationCenter {
	
	func postTabViewItemDidChange(_ selection: ContentTabViewSelection) {
		post(name: .tabViewItemDidChange, object: selection)
	}
}

extension NSNotification.Name {
	
	static let tabViewItemDidChange = NSNotification.Name("tabViewItemDidChange")
}

#Preview {
    TabViewItemWrapperView(path: .constant(.init()), selection: .articles) {
		Text("Hello, World!")
	}
}
