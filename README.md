# Notes

Andrew Hoang
November 3, 2026

## Brief Overview
- Track: SwiftUI
- User flow: Users can browse the starter catalog, open a stock to see its quote, logo, and key metrics, and add or remove it from their watchlist. The Watchlist tab will update accordingly and tapping a watchlist row will open its detail view

## Remarks on Implementation Decisions
- Explicit view state: `StockDetailViewModel` uses a `loading / loaded / failed` enum, so the view just switches on it
- Parallel requests: All three calls needed are set to run at the same time with `async let`
- Dependency injection for the network: The client gets passed in through `FinnhubClientProvider`. When `UI_TESTING` is set, `FinnhubClientFactory` returns a stub, so UI tests don't hit the network. The store is shared through the environment.
- Graceful Failing on detail screen: On the detail screen, only the quote is required - if the company logo or metrics fail, the screen will still be able to load without them


## Implementation Details
- API key provided is kept out of version control, so key will need to be added to Finnhub.plist before running
- Finnhub's `dp` value is already a percentage, so it gets divided by 100 before formatting
- `StockFormatter` handles price and percent formatting and will show a placeholder when a value is missing
- Accessibility identifiers were placed with the main elements so the UI tests can find them reliably

## Testing
- Unit tests: tests include view model states, partial failures, formatting, model decoding, watchlist store, client factory, and endpoints
- UI tests: tests include tab switching, the catalog count header, the detail view showing price and metrics, and add/remove updating the Watchlist tab

## Known Limitations
- Because the watchlist lives in memory, it will reset when the app relaunches

## If I Had More Time
- Persist the watchlist across launches
- Pull to refresh and live price updates
- Search in Browse
- More UI test coverage for the error and retry states
- Cache quotes and profiles, and handle rate limiting (429) better in the UI
