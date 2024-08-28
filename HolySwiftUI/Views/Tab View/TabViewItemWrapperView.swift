//
//  TabViewItemWrapperView.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 7/18/24.
//

import SwiftUI

struct TabViewItemWrapperView<C: View>: View {
    
    @State private var isRefreshing = false
	
    @Binding var contentOffset: CGFloat
	@Binding var path: NavigationPath
	
	let selection: ContentTabViewSelection
	var view: () -> C
    
    @Environment(\.refresh) var refreshAction
	
    var body: some View {
        ScrollViewReader { proxy in
            view()
                .task(id: isRefreshing) {
                    if isRefreshing {
                        await refreshAction?()
                        DispatchQueue.main.async {
                            self.isRefreshing = false
                        }
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: .tabViewItemDidChange)) { notification in
                    if let selection = notification.object as? ContentTabViewSelection, self.selection == selection {
                        //1) Checking the navigation path
                        if !(path.isEmpty) {
                            path = .init()
                        }
                        //2) Check Scroll Position
                        else if !(contentOffset == .zero) {
                            withAnimation {
                                proxy.scrollTo("topOfContentView", anchor: .top)
                            }
                        }
                        //3) Refresh Parent View
                        else if !(isRefreshing) {
                            self.isRefreshing = true
                        }
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
