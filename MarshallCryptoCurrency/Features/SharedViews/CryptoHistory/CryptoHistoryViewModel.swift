//
//  CryptoHistoryViewModel.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//

import CryptoCurrencyService
import SwiftUI

struct CryptoHistoryMark: Identifiable {
    var id = UUID()
    var value: Double
    var dateString: String

    init(
        from exCurHistory: ExchangeCurrencyHistory,
        with exchangeCurrency: ExchangeCurrency
    ) {
        value = (Double(exCurHistory.priceUsd) ?? 0.0) * exchangeCurrency.rate
        dateString = exCurHistory.formattedDate
    }
}

@MainActor
final class CryptoChartViewModel: ObservableObject {
    @Published var historyMarks: [CryptoHistoryMark] = []
    @Published var error: Error? = nil
    @Published var isLoading: Bool = false
    let crypto: CryptoCurrency
    let exchangeCurrency: ExchangeCurrency
    private let cryptoService = CryptoCurrencyService()

    init(
        crypto: CryptoCurrency,
        exchangeCurrency: ExchangeCurrency
    ) {
        self.crypto = crypto
        self.exchangeCurrency = exchangeCurrency
    }

    func getCryptoHistoryChart(
        for exchangeCurrency: ExchangeCurrency,
        in historyInterval: CryptoCurrencyHistoryInterval
    ) async {
        do {
            error = nil
            isLoading = true
            let historyMarks = try await cryptoService.getCryptoExchangeHistory(
                of: crypto.id,
                interval: historyInterval
            )
            .map { CryptoHistoryMark(from: $0, with: exchangeCurrency) }
            withAnimation {
                self.historyMarks = historyMarks
                isLoading = false
            }
        } catch {
            isLoading = false
            self.error = error
        }
    }

    func restartGettingCryptoHistory(
        for exchangeCurrency: ExchangeCurrency,
        in historyInterval: CryptoCurrencyHistoryInterval
    ) async {
        error = nil
        await getCryptoHistoryChart(for: exchangeCurrency, in: historyInterval)
    }
}
