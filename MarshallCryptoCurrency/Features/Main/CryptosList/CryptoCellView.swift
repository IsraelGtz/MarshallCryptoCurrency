//
//  CryptoCellView.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//

import CryptoCurrencyService
import SwiftUI

private struct CryptoData {
    let name: String
    let symbol: String
    let priceUsd: String
    let volume: String
    let variation: CryptoCurrency.VariationType

    let exchangeCurrencyName: String?
    let priceByExchange: Double?
    let numericVolume: Double?

    init(
        from crypto: CryptoCurrency,
        and exchangeCurrency: ExchangeCurrency
    ) {
        name = crypto.name
        symbol = crypto.symbol
        priceUsd = crypto.priceUsd
        volume = crypto.volumeUsd24Hr
        variation = crypto.variation

        if let priceUsd = Double(crypto.priceUsd),
           let volume = Double(crypto.volumeUsd24Hr)
        {
            exchangeCurrencyName = exchangeCurrency.id.rawValue
            priceByExchange = exchangeCurrency.rate * priceUsd
            numericVolume = volume * exchangeCurrency.rate
        } else {
            exchangeCurrencyName = nil
            priceByExchange = nil
            numericVolume = nil
        }
    }

    var numericChangePercent: Double? {
        switch variation {
        case let .increased(variation),
             let .decreased(variation):
            return variation
        case .same:
            return 0
        case .unknown:
            return nil
        }
    }
}

struct CryptoCellView: View {
    @Environment(\.colorScheme) private var colorScheme
    private let data: CryptoData

    init(crypto: CryptoCurrency, exchangeCurrency: ExchangeCurrency) {
        data = CryptoData(from: crypto, and: exchangeCurrency)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .circular)
                .fill(colorScheme == .dark ? Color.white.gradient.opacity(0.25) : Color.gray.gradient.opacity(0.15))
            VStack(spacing: 4) {
                Text(data.name).titleStyle()
                exchangeValueView
                Divider()
                    .overlay(colorScheme == .dark ? .white.opacity(0.25) : .gray.opacity(0.25))
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                Text("Last 24h:").descriptionStyle(size: 15)
                VariationView(variation: data.variation)
                volumeView
            }
            .padding([.horizontal, .vertical], 6)
        }
        .frame(minWidth: 150, idealWidth: 175, maxWidth: 175, minHeight: 150, idealHeight: 175, maxHeight: 175, alignment: .center)
    }

    @ViewBuilder
    private var exchangeValueView: some View {
        if let priceByExchange = data.priceByExchange,
           let exchangeCurrencyName = data.exchangeCurrencyName
        {
            HStack(spacing: 4) {
                Group {
                    Text(String(exchangeCurrencyName))
                    Text(priceByExchange, format: .number.precision(.fractionLength(2))).lineLimit(1)
                }
                .descriptionStyle(size: 18)
            }
        }
    }

    @ViewBuilder
    private var volumeView: some View {
        if let numericVolume = data.numericVolume {
            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Group {
                    Text("Vol:")
                    Text(numericVolume, format: .number.precision(.fractionLength(2))).lineLimit(1)
                }
                .descriptionThinStyle(size: 15)
            }
        }
    }
}
