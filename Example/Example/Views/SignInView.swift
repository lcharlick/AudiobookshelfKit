//
//  SignInView.swift
//  Example
//
//  Created by Lachlan Charlick on 9/4/2024.
//

import AudiobookshelfKit
import SwiftUI

struct SignInView: View {
    @Environment(\.client) private var client
    @Environment(Router.self) private var router
    @Environment(ServerInfo.self) private var serverInfo

    @State private var isLoading = false
    @State private var successMessage: String?
    @State private var errorMessage: String?
    @State private var server = ProcessInfo.processInfo.environment["AUDIOBOOKSHELF_SERVER"] ?? ""
    @State private var username = ProcessInfo.processInfo.environment["AUDIOBOOKSHELF_USERNAME"] ?? ""
    @State private var password = ProcessInfo.processInfo.environment["AUDIOBOOKSHELF_PASSWORD"] ?? ""

    private func signIn() async {
        errorMessage = nil
        successMessage = nil

        guard let serverUrl = URL(string: server) else {
            errorMessage = "Invalid URL"
            return
        }

        isLoading = true

        let request = Audiobookshelf.Request.Login(username: username, password: password)
        let result = await client.request(request, from: serverUrl)
        isLoading = false
        switch result {
        case let .success(response):
            successMessage = "Successfully signed in as \(response.user.username)."
            serverInfo.url = URL(string: server)!
            serverInfo.token = response.user.token
            router.path.append(.libraries)
        case let .failure(error):
            errorMessage = error.description
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
                SecureField("Password", text: $password)
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            Button(action: {
                Task {
                    await signIn()
                }
            }) {
                Text("Sign in")
            }
            .buttonStyle(.borderedProminent)
            .disabled(isLoading || server == "" || username == "")
        }
        .textFieldStyle(.roundedBorder)
        .padding()
        .navigationTitle("AudiobookshelfKit")
    }
}

extension AudiobookshelfError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidRequest:
            return "Invalid request."
        case let .networkError(_, reason):
            switch reason {
            case let .urlSessionError(error):
                return "HTTP error: \(error)"
            case let .unacceptableStatusCode(statusCode):
                return "Unacceptable status code: \(statusCode)"
            }
        case let .decodingFailed(_, error):
            return "Decoding failed: \(error)"
        case .notAuthenticated:
            return "Not authenticated"
        }
    }
}

#Preview {
    SignInView()
        .environment(ServerInfo.mock)
        .environment(Router())
}
