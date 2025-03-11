//
//  Styles.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//
import SwiftUI

enum Styles {
    struct Title: ViewModifier {
        @Environment(\.colorScheme) private var colorScheme
        let size: CGFloat?

        func body(content: Content) -> some View {
            content
                .font(Fonts.boldItalic(size: size ?? 20).font)
                .minimumScaleFactor(0.4)
                .foregroundStyle(colorScheme == .dark ? .white : .black.opacity(0.9))
                .lineLimit(2)
        }
    }

    struct Label: ViewModifier {
        @Environment(\.colorScheme) private var colorScheme
        let size: CGFloat?

        func body(content: Content) -> some View {
            content
                .font(Fonts.demiBold(size: size ?? 15).font)
                .minimumScaleFactor(0.75)
                .foregroundStyle(colorScheme == .dark ? .white : .black.opacity(0.65))
                .lineLimit(1)
        }
    }

    struct Description: ViewModifier {
        @Environment(\.colorScheme) private var colorScheme
        let size: CGFloat?
        let color: Color?

        func body(content: Content) -> some View {
            content
                .font(Fonts.medium(size: size ?? 16).font)
                .minimumScaleFactor(0.9)
                .foregroundStyle(color ?? (colorScheme == .dark ? .white : .black.opacity(0.9)))
        }
    }

    struct DescriptionThin: ViewModifier {
        @Environment(\.colorScheme) private var colorScheme
        let size: CGFloat?

        func body(content: Content) -> some View {
            content
                .font(Fonts.regular(size: size ?? 16).font)
                .minimumScaleFactor(0.75)
                .foregroundStyle(colorScheme == .dark ? .white : .black.opacity(0.8))
        }
    }

    struct SubDescription: ViewModifier {
        @Environment(\.colorScheme) private var colorScheme
        let size: CGFloat?

        func body(content: Content) -> some View {
            content
                .font(Fonts.italic(size: size ?? 14).font)
                .minimumScaleFactor(0.8)
                .foregroundStyle(colorScheme == .dark ? .white : .gray)
        }
    }
}
