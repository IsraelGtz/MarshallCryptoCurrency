//
//  CryptoHistoryView.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//

import CryptoCurrencyService
import SwiftUI

struct CryptoHistoryView: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var viewModel: CryptoChartViewModel
    @State private var tapLocation: CGPoint = .zero
    @State private var tapTrigger: Int = 0
    private let version: CryptoChartVersion

    init(
        crypto: CryptoCurrency,
        exchangeCurrency: ExchangeCurrency,
        version: CryptoChartVersion = .normal
    ) {
        _viewModel = StateObject(wrappedValue: CryptoChartViewModel(crypto: crypto, exchangeCurrency: exchangeCurrency))
        self.version = version
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .circular)
                .fill(colorScheme == .dark ? Color.white.gradient.opacity(0.25) : Color.gray.gradient.opacity(0.15))

            if viewModel.isLoading {
                // If I use ProgresView it won't work due to ripple effect so I decided to use an image.
                // In the other hand loading is really fast so not to much to worry about being a static image.
                Image(systemName: "progress.indicator")
                    .foregroundStyle(.gray)
                    .padding()
            } else
            if let error = viewModel.error {
                ErrorView(error: error, isReloadButtonShown: version == .normal) {
                    Task {
                        await viewModel.restartGettingCryptoHistory(
                            for: viewModel.exchangeCurrency,
                            in: .d1
                        )
                    }
                }
            } else
            if !viewModel.isLoading,
               !viewModel.historyMarks.isEmpty
            {
                CryptoChartView(
                    marks: viewModel.historyMarks,
                    exCur: viewModel.exchangeCurrency,
                    version: version
                )
                .transition(.scale.combined(with: .blurReplace))
            }
        }
        .onTapGesture { location in
            tapLocation = location
            tapTrigger += 1
        }
        .modifier(RippleEffect(trigger: tapTrigger, origin: tapLocation))
        .padding()
        .task {
            await viewModel.getCryptoHistoryChart(
                for: viewModel.exchangeCurrency,
                in: .d1
            )
        }
    }
}
