//
//  UserViewModel.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 9/7/24.
//

import Foundation
import UIKit

final class UserViewModel: ObservableObject {
    
    @Published var profilePicture: UIImage? = .profilePicture
    @Published var name = "Jaylen Smith"
}
