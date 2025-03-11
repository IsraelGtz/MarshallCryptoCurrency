//
//  VariationView.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//

import CryptoCurrencyService
import SwiftUI

struct VariationView: View {
    let variation: CryptoCurrency.VariationType
    let size: CGFloat?

    private var variationImage: (some View)? {
        switch variation {
        case .increased:
            Image(systemName: "arrowtriangle.up.fill")
                .font(.system(size: size != nil ? (size ?? 10) - 6 : 10))
        case .decreased:
            Image(systemName: "arrowtriangle.down.fill")
                .font(.system(size: size != nil ? (size ?? 10) - 6 : 10))
        case .same, .unknown:
            nil
        }
    }

    private var variationLabelColor: Color {
        switch variation {
        case .increased: .green
        case .decreased: .red
        case .same, .unknown: .black
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

    init(variation: CryptoCurrency.VariationType, size: CGFloat? = nil) {
        self.variation = variation
        self.size = size
    }

    var body: some View {
        if let numericPct = numericChangePercent {
            HStack(alignment: .center, spacing: 2) {
                Group {
                    if let variationImage {
                        variationImage
                    }
                    Text(numericPct, format: .percent.scale(1).precision(.fractionLength(4)))
                        .descriptionStyle(size: size, color: variationLabelColor)
                }
                .foregroundStyle(variationLabelColor)
            }
        }
    }
}
