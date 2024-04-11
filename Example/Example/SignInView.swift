//
//  SignInView.swift
//  Example
//
//  Created by Lachlan Charlick on 9/4/2024.
//

import SwiftUI
import AudiobookshelfKit

struct SignInView: View {
    @Environment(\.client) private var client
    @Environment(Router.self) private var router

    @State private var isLoading = false
    @State private var successMessage: String?
    @State private var errorMessage: String?
    @State private var server = ProcessInfo.processInfo.environment["AUDIOBOOKSHELF_SERVER"] ?? ""
    @State private var username = ProcessInfo.processInfo.environment["AUDIOBOOKSHELF_USERNAME"] ?? ""
    @State private var password = ProcessInfo.processInfo.environment["AUDIOBOOKSHELF_PASSWORD"] ?? ""

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
                let serverInfo = ServerInfo(url: URL(string: server)!, token: response.user.token)
                router.path.append(.libraries(serverInfo))
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
                SecureField("Password", text: $password)
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            Button(action: signIn) {
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
    SignInView()
}
