//
//  GameSetupView.swift
//  CSAT_App
//
//  Created by Shivani Verma on 15/12/25.
//


import SwiftUI

struct GameSetupView: View {

    @State private var showCSAT = false

    var body: some View {
        ZStack {

            VStack(spacing: 18) {

                Image(systemName: "gamecontroller.fill")
                    .font(.system(size: 72))
                    .foregroundColor(.purple)

                Text("Game Setup")
                    .font(.system(size: 26, weight: .bold))

                Text("Campaigns: 0")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)

                Text("No campaigns for this screen")
                    .font(.system(size: 13))
                    .foregroundColor(.gray.opacity(0.6))

                Spacer()

                Button {
                    withAnimation(.spring()) {
                        showCSAT = true
                    }
                } label: {
                    Text("Rate")
                        .font(.system(size: 15, weight: .semibold))
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)

            if showCSAT {
                CSATBottomSheet(isPresented: $showCSAT)
                    .transition(.move(edge: .bottom))
            }
        }
        .navigationTitle("Third Setup")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                }
            }
        }
    }
}
