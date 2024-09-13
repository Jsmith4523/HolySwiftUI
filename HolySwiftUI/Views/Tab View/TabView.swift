//
//  ContentView.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 5/4/24.
//

import SwiftUI

struct ContentView: View {
	
    @State private var selection: ContentTabViewSelection = .profile
    
    @StateObject private var userVM = UserViewModel()
    
    @Environment(\.colorScheme) var colorScheme
	
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
            ProfileView()
                .tag(ContentTabViewSelection.profile)
                .environmentObject(userVM)
                .tabItem {
                    //1) Display for state
                    //2) Redraw for color scheme
                    profileTabItemLabel()
                }
		}
        .tint(.primary)
    }
	
	private var binding: Binding<ContentTabViewSelection> {
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

private extension ContentView {
    
    @ViewBuilder
    private func profileTabItemLabel() -> some View {
        ZStack {
            Label {
                Text(ContentTabViewSelection.profile.rawValue)
            } icon: {
                if let profilePicture = (userVM.profilePicture)?.createTabItemLabelFromImage(selection == .profile) {
                    Image(uiImage: profilePicture)
                } else {
                    Image(systemName: ContentTabViewSelection.profile.symbol)
                }
            }
        }
        .animation(.none, value: colorScheme)
    }
}

fileprivate extension UIImage {
    
    func createTabItemLabelFromImage(_ isSelected: Bool) -> UIImage? {
        let imageSize = CGSize(width: 25, height: 25)
        
        return UIGraphicsImageRenderer(size: imageSize).image { context in
            let rect = CGRect(origin: .init(x: 0, y: 0), size: imageSize)
            let clipPath = UIBezierPath(ovalIn: rect)
            clipPath.addClip()
            
            self.draw(in: rect)
            if isSelected {
                context.cgContext.setStrokeColor(UIColor.label.cgColor)
                context.cgContext.setLineJoin(.round)
                context.cgContext.setLineCap(.round)
                clipPath.lineWidth = 3
                
                clipPath.stroke()
            }
        }
        .withRenderingMode(.alwaysOriginal)
    }
}


#Preview {
    ContentView()
}
