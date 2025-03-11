//
//  MainView.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//

import CryptoCurrencyService
import SwiftUI

struct MainView: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject var viewModel = MainViewModel()
    @State private var showExchangeCurrencies = false
    @State private var selectedExchangeCurrency: ExchangeCurrency = .init(id: .USD, rate: 1.0)

    var body: some View {
        NavigationStack {
            VStack {
                if let error = viewModel.cryptosError {
                    ErrorView(error: error) {
                        Task {
                            await viewModel.restartLoadingCryptos()
                        }
                    }
                } else if !viewModel.cryptos.isEmpty {
                    CryptosListView(
                        cryptos: viewModel.cryptos,
                        selectedExCur: selectedExchangeCurrency
                    )
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Marshall Cryptos")
            .toolbar {
                if viewModel.exchangeCurrenciesError != nil {
                    restarExchangeCurrenciesButton
                }
                if viewModel.areExchangeCurrenciesLoaded {
                    exchangeCurrenciesButton
                }
            }
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
            .refreshable {
                await viewModel.getCryptos()
            }
        }
        .colorScheme(colorScheme)
        .task {
            await viewModel.getCryptos()
            await viewModel.getAllExchangeCurrencies(excluding: selectedExchangeCurrency)
        }
    }

    @ToolbarContentBuilder
    private var exchangeCurrenciesButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                showExchangeCurrencies = true
            } label: {
                Text("Currency")
                    .descriptionStyle(size: 16)
                    .foregroundStyle(.black.opacity(0.85))
                    .padding([.horizontal, .vertical], 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .circular)
                            .fill(colorScheme == .dark ? Color.white.gradient.opacity(0.25) : Color.gray.gradient.opacity(0.15))
                    )
            }
            .confirmationDialog(
                "Exchange currencies",
                isPresented: $showExchangeCurrencies,
                titleVisibility: .hidden
            ) {
                ForEach(viewModel.resolveExchangeCurrencies(excluding: selectedExchangeCurrency)) { exCur in
                    Button {
                        withAnimation(.smooth) {
                            selectedExchangeCurrency = exCur
                        }
                    } label: {
                        Text(exCur.id.rawValue)
                    }
                }
            } message: {
                Text("Select a currency")
            }
        }
    }

    @ToolbarContentBuilder
    private var restarExchangeCurrenciesButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                Task {
                    await viewModel.restartLoadingAllExchangeCurrencies(excluding: selectedExchangeCurrency)
                }
            } label: {
                Text("Reload currencies")
                    .descriptionStyle(size: 12)
                    .foregroundStyle(.black.opacity(0.85))
                    .padding([.horizontal, .vertical], 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .circular)
                            .fill(colorScheme == .dark ? Color.white.gradient.opacity(0.25) : Color.gray.gradient.opacity(0.15))
                    )
            }
        }
    }
}

#Preview {
    MainView()
}
