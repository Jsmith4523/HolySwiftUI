//
//  ProfileView.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 9/7/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack {
                    Image(uiImage: userVM.profilePicture ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    Text(userVM.name)
                        .font(.system(size: 22).bold())
                }
                
                VStack(spacing: 10) {
                    Button("Remove Profile Picture") {
                        userVM.profilePicture = nil
                    }
                    Button("Set Profile Picture") {
                        userVM.profilePicture = .profilePicture
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(UserViewModel())
}
