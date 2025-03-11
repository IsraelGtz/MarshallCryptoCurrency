//
//  View+Extensions.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//

import SwiftUI

extension View {
    func titleStyle(size: CGFloat? = nil) -> some View {
        modifier(Styles.Title(size: size))
    }

    func labelStyle(size: CGFloat? = nil) -> some View {
        modifier(Styles.Label(size: size))
    }

    func descriptionStyle(
        size: CGFloat? = nil,
        color: Color? = nil
    ) -> some View {
        modifier(Styles.Description(size: size, color: color))
    }

    func descriptionThinStyle(size: CGFloat? = nil) -> some View {
        modifier(Styles.DescriptionThin(size: size))
    }

    func subDescriptionStyle(size: CGFloat? = nil) -> some View {
        modifier(Styles.SubDescription(size: size))
    }
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
