//
//  FinnhubClient.swift
//  StockWatchlist
//

import Foundation

struct FinnhubClient: FinnhubClientProvider {
    private let apiKey: String
    private let session: any URLSessionProvider
    private let decoder: JSONDecoder

    init(apiKey: String, session: any URLSessionProvider = URLSession.shared) {
        self.apiKey = apiKey
        self.session = session
        self.decoder = JSONDecoder()
    }

    static func configured() -> FinnhubClient {
        if FinnhubConfiguration.isRunningTests {
            return FinnhubClient(apiKey: FinnhubConfiguration.testApiKey)
        }
        guard let apiKey = FinnhubConfiguration.apiKey else {
            fatalError("Finnhub API key not configured. Check that Finnhub.plist is present in the app bundle.")
        }
        return FinnhubClient(apiKey: apiKey)
    }

    func fetchQuote(symbol: String) async throws -> StockQuote {
        try await request(.quote(symbol: symbol))
    }

    func fetchCompanyProfile(symbol: String) async throws -> CompanyProfile {
        try await request(.companyProfile(symbol: symbol))
    }

    func fetchMetrics(symbol: String) async throws -> StockMetrics {
        let response: StockMetricsResponse = try await request(.stockMetrics(symbol: symbol))
        return response.metric
    }

    private func request<T: Decodable>(_ endpoint: FinnhubEndpoint) async throws -> T {
        let request = try makeRequest(for: endpoint)
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw FinnhubAPIError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200:
            break
        case 429:
            throw FinnhubAPIError.rateLimited
        default:
            let message = String(data: data, encoding: .utf8)
            throw FinnhubAPIError.httpError(statusCode: httpResponse.statusCode, message: message)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw FinnhubAPIError.decodingFailed(underlying: error)
        }
    }

    private func makeRequest(for endpoint: FinnhubEndpoint) throws -> URLRequest {
        guard var components = URLComponents(
            url: FinnhubConfiguration.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        ) else {
            throw FinnhubAPIError.invalidURL
        }

        components.queryItems = endpoint.queryItems(apiKey: apiKey)

        guard let url = components.url else {
            throw FinnhubAPIError.invalidURL
        }

        return URLRequest(url: url)
    }
}
