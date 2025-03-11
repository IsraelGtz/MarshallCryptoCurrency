//
//  Fonts.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//
import SwiftUI

enum Fonts {
    case ultraLight(size: CGFloat = 15)
    case regular(size: CGFloat = 15)
    case italic(size: CGFloat = 15)
    case medium(size: CGFloat = 15)
    case demiBold(size: CGFloat = 15)
    case demiBoldItalic(size: CGFloat = 15)
    case bold(size: CGFloat = 15)
    case boldItalic(size: CGFloat = 15)

    var font: Font {
        switch self {
        case let .ultraLight(size):
            .custom("AvenirNext-UltraLight", size: size)
        case let .regular(size):
            .custom("AvenirNext-Regular", size: size)
        case let .italic(size):
            .custom("AvenirNext-Italic", size: size)
        case let .medium(size):
            .custom("AvenirNext-Medium", size: size)
        case let .demiBold(size):
            .custom("AvenirNext-DemiBold", size: size)
        case let .demiBoldItalic(size):
            .custom("AvenirNext-DemiBoldItalic", size: size)
        case let .bold(size):
            .custom("AvenirNext-Bold", size: size)
        case let .boldItalic(size):
            .custom("AvenirNext-BoldItalic", size: size)
        }
    }
}
