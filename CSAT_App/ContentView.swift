//
//  ContentView.swift
//  CSAT_App
//
//  Created by Shivani Verma on 15/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            GameSetupView()
                .navigationTitle("Third Setup")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
#Preview {
    ContentView()
}
