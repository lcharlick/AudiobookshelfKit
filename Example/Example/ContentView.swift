//
//  ContentView.swift
//  Example
//
//  Created by Lachlan Charlick on 9/4/2024.
//

import SwiftUI
import AudiobookshelfKit

struct ContentView: View {
    private let client = Audiobookshelf(sessionConfiguration: .default)
    @State private var isLoading = false
    @State private var successMessage: String?
    @State private var errorMessage: String?
    @State private var server = ""
    @State private var username = ""
    @State private var password = ""

    private func signIn() {
        errorMessage = nil
        successMessage = nil

        guard let serverUrl = URL(string: server) else {
            errorMessage = "Invalid URL"
            return
        }

        isLoading = true

        let request = Audiobookshelf.Request.Login(username: username, password: password)
        client.request(request, from: serverUrl) { result in
            isLoading = false
            switch result {
            case .success(let response):
                successMessage = "Successfully signed in as \(response.user.username)."
            case .failure(let error):
                errorMessage = error.description
            }
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            if let errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }
            if let successMessage {
                Text(successMessage)
                    .foregroundStyle(.green)
            }
            VStack {
                TextField("Server address", text: $server)
                TextField("Username", text: $username)
                TextField("Password", text: $password)
            }
            .textInputAutocapitalization(.never)
            Button(action: signIn) {
                Text("Sign in")
            }
            .buttonStyle(.borderedProminent)
            .disabled(isLoading || server == "" || username == "")
        }
        .textFieldStyle(.roundedBorder)
        .padding()
    }
}

extension AudiobookshelfError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidRequest(let reason):
            return "Invalid request."
        case .networkError(_, let reason):
            switch reason {
            case .httpError(let error):
                if let error {
                    return "HTTP error: \(error)"
                }
                return "An unknown HTTP error occurred."
            case .unacceptableStatusCode(let statusCode):
                return "Unacceptable status code: \(statusCode)"
            }
        case .decodingFailed(_, _):
            return "Decoding failed"
        case .notAuthenticated:
            return "Not authenticated"
        }
    }
}

#Preview {
    ContentView()
}
