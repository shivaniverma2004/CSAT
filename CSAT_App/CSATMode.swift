//
//  CSATMode.swift
//  CSAT_App
//
//  Created by Shivani Verma on 15/12/25.
//

import SwiftUI

enum CSATMode {
    case ratingOnly
    case feedback
    case thankYou
}

struct CSATBottomSheet: View {

    @Binding var isPresented: Bool

    @State private var mode: CSATMode = .ratingOnly
    @State private var rating = 0
    @State private var issue = ""
    @State private var improvement = ""
    @State private var comments = ""

    var body: some View {
        Color.clear
            .safeAreaInset(edge: .bottom) {
                card
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
            }
    }

    private var card: some View {
        VStack(spacing: 20) {

            if mode != .thankYou {
                headerRow
                starsRow
            }

            if mode == .feedback {
                feedbackSection
            }

            if mode == .thankYou {
                thankYouSection
            }

            if mode != .ratingOnly {
                ctaButton
            }

            if mode == .feedback {
                Spacer()
            }
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 26))
        .overlay(
            RoundedRectangle(cornerRadius: 26)
                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
        )
        .overlay(alignment: .topTrailing) {
            closeButton
        }
    }
}

private extension CSATBottomSheet {

    var headerRow: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("How would you rate your experience?")
                .font(.system(size: 16, weight: .semibold))

            Text("We value your feedback!")
                .font(.system(size: 13))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private extension CSATBottomSheet {

    var starsRow: some View {
        HStack(spacing: 14) {
            ForEach(1...5, id: \.self) { star in
                Image(systemName: rating >= star ? "star.fill" : "star")
                    .font(rating >= star ? .system(size: 36) : .system(size: 30))
                    .foregroundColor(rating >= star ? .red : .gray.opacity(0.3))
                    .onTapGesture {
                        rating = star

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
                                mode = star >= 3 ? .thankYou : .feedback
                            }
                        }
                    }

            }
        }
        .padding(.top, 4)
    }
}

private extension CSATBottomSheet {

    var feedbackSection: some View {
        VStack(spacing: 14) {

            TextField("one", text: $issue)
                .padding(14)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                )

            TextField("to", text: $improvement)
                .padding(14)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                )

            VStack(alignment: .leading, spacing: 6) {
                Text("Additional Comments")
                    .font(.system(size: 13, weight: .medium))

                ZStack(alignment: .topLeading) {

                    if comments.isEmpty {
                        Text("Write your feedback...")
                            .foregroundColor(.gray.opacity(0.6))
                            .padding(.top, 14)
                            .padding(.leading, 18)
                    }

                    TextEditor(text: $comments)
                        .frame(height: 90)
                        .padding(10)
                        .scrollContentBackground(.hidden)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                        )
                }
            }
        }
    }
}

private extension CSATBottomSheet {

    var thankYouSection: some View {
        VStack(spacing: 16) {
            Image("flutter")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 180)

            Text("Thank You for your feedback!")
                .font(.system(size: 18, weight: .semibold))

            Text("Your insight will help us improve.")
                .font(.system(size: 14))
        }
        .frame(maxWidth: .infinity)
    }
}

private extension CSATBottomSheet {

    var ctaButton: some View {
        Button {
            withAnimation {
                if mode == .feedback {
                    mode = .thankYou
                } else {
                    isPresented = false
                }
            }
        } label: {
            Text(buttonTitle)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.black)
                .cornerRadius(26)
        }
        .padding(.top, 6)
    }

    var buttonTitle: String {
        mode == .feedback
        ? "Submit"
        : (rating < 3 ? "bad experience" : "good experience")
    }
}

private extension CSATBottomSheet {

    var closeButton: some View {
        Button {
            isPresented = false
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.gray)
                .frame(width: 28, height: 28)
                .background(Color.gray.opacity(0.15))
                .clipShape(Circle())
        }
        .offset(x: -10, y: 10)
    }
}
