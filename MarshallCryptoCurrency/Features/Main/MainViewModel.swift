//
//  MainViewModel.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//

import CryptoCurrencyService
import SwiftUI

enum ContentViewModelError: Error {
    case invalidSEKCurrency
}

@MainActor
class MainViewModel: ObservableObject {
    @Published var cryptos: [CryptoCurrency] = []
    @Published var cryptosError: Error?
    @Published var areExchangeCurrenciesLoaded = false
    @Published var exchangeCurrenciesError: Error?
    @Published var exchangeCurrencies: [ExchangeCurrency] = []
    private var isLoading = false
    private let cryptoService = CryptoCurrencyService()

    func getCryptos() async {
        guard !isLoading else {
            return
        }
        do {
            isLoading = true
            let fetchedCryptos = try await cryptoService.getCryptoCurrencies()
            isLoading = false
            cryptos = fetchedCryptos
        } catch {
            cryptosError = error
            isLoading = false
        }
    }

    func restartLoadingCryptos() async {
        cryptosError = nil
        await getCryptos()
    }

    func getAllExchangeCurrencies(excluding selectedCurrency: ExchangeCurrency) async {
        do {
            let allExchangeCurrencies = try await cryptoService.getExchangeCurrencies()
            let finalSortedCurrencies = sort(allExchangeCurrencies, excluding: selectedCurrency)
            exchangeCurrencies = finalSortedCurrencies
            areExchangeCurrenciesLoaded = true
        } catch {
            exchangeCurrenciesError = error
            areExchangeCurrenciesLoaded = false
        }
    }

    func restartLoadingAllExchangeCurrencies(excluding selectedCurrency: ExchangeCurrency) async {
        exchangeCurrenciesError = nil
        await getAllExchangeCurrencies(excluding: selectedCurrency)
    }

    func resolveExchangeCurrencies(excluding currency: ExchangeCurrency) -> [ExchangeCurrency] {
        let currencies = exchangeCurrencies
        return sort(currencies, excluding: currency)
    }

    /// It will exclude the given currency and return the sorted fetched currencies always moving SEK and USD currency at the beginning of the array if applies.
    private func sort(_ currencies: [ExchangeCurrency], excluding currencyToExclude: ExchangeCurrency) -> [ExchangeCurrency] {
        // First we sort the fetched currencies by id
        var sortedCurrencies = Set<ExchangeCurrency>(currencies).sorted { lhs, rhs in
            lhs.id.rawValue < rhs.id.rawValue
        }

        // The endpoint we use to get the exchange currencies doesn't provide USD currency
        // so we insert it as first element inside the sorted currencies
        sortedCurrencies.insert(ExchangeCurrency(id: .USD, rate: 1.0), at: 0)

        // We search inside the sorted currencies for SEK
        // if it exists we move it at the beginning of the sorted currencies
        if let sekIndex = sortedCurrencies.firstIndex(where: { currency in
            currency.id == .SEK
        }) {
            let sekCurrency = sortedCurrencies.remove(at: sekIndex)
            sortedCurrencies.insert(sekCurrency, at: 0)
        }

        // We finally remove the currency to exclude
        sortedCurrencies.removeAll { currency in
            currency.id == currencyToExclude.id
        }

        return sortedCurrencies
    }

    func getUsdExchangeCurrency(for currency: Currency = .SEK) -> ExchangeCurrency? {
        exchangeCurrencies.first { exCur in
            exCur.id == currency
        }
    }
}
