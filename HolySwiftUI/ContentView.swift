//
//  ContentView.swift
//  HolySwiftUI
//
//  Created by Jaylen Smith on 5/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .sheet(isPresented: .constant(true), content: {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Sheet Content")/*@END_MENU_TOKEN@*/
        })
    }
}

#Preview {
    ContentView()
}
