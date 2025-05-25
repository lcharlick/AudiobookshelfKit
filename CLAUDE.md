# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

AudiobookshelfKit is a Swift Package Manager library that provides an API client for the Audiobookshelf server. It's designed to be the foundation for Prologue's Audiobookshelf support across Apple platforms (iOS 16+, macOS 13+, watchOS 9+, tvOS 16+).

## Commands

### Building and Testing
- **Build**: `swift build`
- **Run tests**: `swift test`
- **Run single test**: `swift test --filter <TestClassName>`
- **Build example app**: Open `Example/Example.xcodeproj` in Xcode

### Development
- Use Xcode for the example app development
- Swift Package Manager for library development and testing

## Architecture

### Core Client (`AudiobookshelfKit.swift`)
The main `Audiobookshelf` class is a URL session-based HTTP client that:
- Handles authentication via Bearer tokens or query parameters
- Processes requests through a generic `ResourceRequest` protocol
- Returns typed `Result<Response, AudiobookshelfError>` values
- Uses milliseconds-since-1970 date encoding/decoding strategy

### Request System (`Requests/`)
All API calls implement the `ResourceRequest` protocol:
- `path`: API endpoint path
- `httpMethod`: HTTP method (defaults to GET)
- `queryItems`: URL query parameters
- `httpBody`: Codable request body
- `Response`: Associated response type

New requests should be added to the `Audiobookshelf.Request` namespace and follow existing patterns.

### Models (`Models/`)
Data models represent Audiobookshelf API responses:
- All models are `Codable` with camelCase Swift properties
- Use `@CodingKey` annotations when API uses snake_case
- Optional properties should match API documentation
- Models often have "Expanded" and "Minified" variants

### Testing (`Tests/`)
- Tests use mock JSON responses stored in `Resources/`
- `BaseTestCase` provides common testing utilities
- `loadResponse()` helper loads and decodes test JSON files
- Test URL: `http://192.168.0.100:32400`

### Example App (`Example/`)
Demonstrates library usage with:
- Environment setup (`Environment/`)
- Player service (`Services/Player.swift`)
- Router for navigation (`Services/Router.swift`)
- SwiftUI views for library browsing

## Audiobookshelf API Guidelines

### Authentication
- Bearer token authentication (from `/login` endpoint)
- Token passed via Authorization header: `Authorization: Bearer <token>`
- Query parameter authentication supported for GET requests: `?token=<token>`
- Client implements both strategies via `TokenStrategy` enum

### Common Query Parameters
Many endpoints support standardized pagination and filtering:
- `limit`: Number of results per page
- `page`: Zero-indexed page number
- `sort`: Field to sort by
- `desc`: Boolean for reverse sort order
- `filter`: Base64 encoded filter parameters

### Response Patterns
Paginated responses typically include:
- `results`: Array of entities
- `total`: Total result count
- `limit`: Applied result limit
- `page`: Current page number

### Error Handling
- 200: Success
- 400: Bad request
- 401: Unauthorized (invalid/missing token)
- 404: Resource not found

## Key Patterns

- All API requests are async and return `Result` types
- Authentication tokens are passed per-request, not stored in client
- Models follow Audiobookshelf API naming conventions
- Error handling distinguishes between request, network, and decoding failures
- Pagination uses zero-indexed pages
- Filters are Base64 encoded when used in query parameters