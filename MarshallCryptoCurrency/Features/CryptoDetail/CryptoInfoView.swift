//
//  CryptoInfoView.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//
import CryptoCurrencyService
import SwiftUI

struct CryptoInfoView: View {
    let crypto: CryptoCurrency
    let exCur: ExchangeCurrency

    var body: some View {
        VStack(spacing: 10) {
            headerView
                .padding(.bottom, -12)
            Divider()
                .padding(.bottom, 12)
            cryptoDetailView(label: "Market Cap:", detail: crypto.marketCapUsd, exCur: exCur, showCurrency: true)
            cryptoDetailView(label: "Total supply:", detail: crypto.supply, exCur: exCur)
            cryptoDetailView(label: "Max supply:", detail: crypto.maxSupply, exCur: exCur)
            cryptoDetailView(label: "Volume Weighted Average Price:", detail: crypto.vwap24Hr, exCur: exCur, showCurrency: true)
        }
        .padding()
    }

    @ViewBuilder
    private var headerView: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(crypto.symbol)
                .titleStyle()
                .padding(.trailing, 6)
            if let price = crypto.getPriceUsd(from: exCur) {
                Group {
                    Text(exCur.id.rawValue)
                        .padding(.trailing, -4)
                    Text(price, format: .number.precision(.fractionLength(4))).lineLimit(1)
                }.titleStyle(size: 16)
            }
            VariationView(variation: crypto.variation, size: 14)
            Spacer()
        }
    }

    @ViewBuilder
    private func cryptoDetailView(
        label: String,
        detail: String?,
        exCur: ExchangeCurrency,
        showCurrency: Bool = false
    ) -> some View {
        if let strDetail = detail,
           let numericDetail = Double(strDetail)
        {
            HStack(alignment: .lastTextBaseline) {
                Text(label)
                    .labelStyle()
                if showCurrency {
                    Text(exCur.id.rawValue)
                        .descriptionStyle()
                        .padding(.trailing, -4)
                }
                Text(numericDetail * exCur.rate, format: .number.precision(.fractionLength(4))).lineLimit(1)
                    .descriptionStyle()
                Spacer()
            }
        }
    }
}
