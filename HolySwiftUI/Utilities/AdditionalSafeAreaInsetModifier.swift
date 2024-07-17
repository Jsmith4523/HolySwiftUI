//
//  AdditionalSafeAreaInsetModifier.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 7/17/24.
//

import Foundation
import SwiftUI
import UIKit

extension View {
	
	func additionalSafeAreaInsetModifier(inset: UIEdgeInsets) -> some View {
		return self.background {
			AdditionalSafeAreaInsetModifierViewControllerRepresentable(
				additionalSafeAreaInsets: inset) { }
		}
	}
}

struct AdditionalSafeAreaInsetModifierViewControllerRepresentable<C: View>: UIViewControllerRepresentable {
	
	typealias UIViewControllerType = UIHostingController<C>
	
	private let additionalSafeAreaInsets: UIEdgeInsets
	private let rootView: () -> C
	
	init(additionalSafeAreaInsets: UIEdgeInsets, @ViewBuilder rootView: @escaping () -> C) {
		self.additionalSafeAreaInsets = additionalSafeAreaInsets
		self.rootView = rootView
	}
	
	func makeUIViewController(context: Context) -> UIHostingController<C> {
		let hostingController = UIHostingController(rootView: rootView())
		hostingController.additionalSafeAreaInsets = additionalSafeAreaInsets
		return hostingController
	}
	
	func updateUIViewController(_ uiViewController: UIHostingController<C>, context: Context) {}
}
