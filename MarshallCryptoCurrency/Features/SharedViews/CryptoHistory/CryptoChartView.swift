//
//  CryptoChartView.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//
import Charts
import CryptoCurrencyService
import SwiftUI

enum CryptoChartVersion {
    case normal
    case preview
}

struct CryptoChartView: View {
    let marks: [CryptoHistoryMark]
    let exCur: ExchangeCurrency
    private let version: CryptoChartVersion

    init(marks: [CryptoHistoryMark], exCur: ExchangeCurrency, version: CryptoChartVersion = .normal) {
        self.marks = marks
        self.exCur = exCur
        self.version = version
    }

    var body: some View {
        VStack {
            if version == .normal {
                Text("Historical data of 1 year")
                    .descriptionThinStyle()
                    .padding()
            }
            Chart {
                ForEach(marks) { mark in
                    LineMark(
                        x: .value("Date", mark.dateString),
                        y: .value("Price", mark.value)
                    )
                }
                if version == .normal {
                    RuleMark(y: .value("Average", averageHistoryMark()))
                        .annotation(alignment: .leading) {
                            HStack {
                                Group {
                                    Text("Average price")
                                        .padding(.trailing, 4)
                                    Text("\(exCur.id.rawValue) \(averageHistoryMark())")
                                }
                                .descriptionThinStyle(size: 14)
                            }
                        }
                        .lineStyle(.init(lineWidth: 1))
                        .foregroundStyle(.red)
                        .blur(radius: 0.65)
                }
            }
            .chartXAxis(.hidden)
            .if(version == .normal, transform: { view in
                view.frame(height: 225)
            })
            .if(version == .preview, transform: { view in
                view.frame(minWidth: 300, idealHeight: 225)
            })
            .padding()
        }
    }

    private func averageHistoryMark() -> Double {
        marks.reduce(.zero) { partialResult, mark in
            partialResult + mark.value
        } / Double(marks.count)
    }
}
