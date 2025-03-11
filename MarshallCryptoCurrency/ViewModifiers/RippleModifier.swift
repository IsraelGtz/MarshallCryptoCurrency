//
//  RippleModifier.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//
import Metal
import SwiftUI

struct RippleModifier: ViewModifier {
    var origin: CGPoint
    var elapsedTime: TimeInterval

    var duration: Double
    var amplitude: Double
    var frecuency: Double
    var decay: Double
    var speed: Double

    var maxSampleOffset: CGSize {
        CGSize(width: amplitude, height: amplitude)
    }

    func body(content: Content) -> some View {
        let shader = ShaderLibrary.Ripple(
            .float2(origin),
            .float(elapsedTime),
            // parameters
            .float(amplitude),
            .float(frecuency),
            .float(decay),
            .float(speed)
        )
        let maxSampleOffset = maxSampleOffset
        let elapsedTime = elapsedTime
        let duration = duration
        content.visualEffect { view, _ in
            view.layerEffect(
                shader,
                maxSampleOffset: maxSampleOffset,
                isEnabled: (elapsedTime > 0) && (elapsedTime < duration)
            )
        }
    }
}

// Building an interactive Ripple Effect
struct RippleEffect<T: Equatable>: ViewModifier {
    var trigger: T
    var origin: CGPoint
    var amplitude: Double
    var frecuency: Double
    var decay: Double
    var speed: Double

    var duration: TimeInterval { 3 }

    init(
        trigger: T,
        origin: CGPoint,
        amplitude: Double = 12,
        frecuency: Double = 15,
        decay: Double = 8,
        speed: Double = 1200
    ) {
        self.trigger = trigger
        self.origin = origin
        self.amplitude = amplitude
        self.frecuency = frecuency
        self.decay = decay
        self.speed = speed
    }

    func body(content: Content) -> some View {
        let origin = origin
        let duration = duration
        let amplitude = amplitude
        let frecuency = frecuency
        let decay = decay
        let speed = speed

        content.keyframeAnimator(initialValue: 0, trigger: trigger) { view, elapsedTime in
            view.modifier(RippleModifier(
                origin: origin,
                elapsedTime: elapsedTime,
                duration: duration,
                amplitude: amplitude,
                frecuency: frecuency,
                decay: decay,
                speed: speed
            )
            )
        } keyframes: { _ in
            MoveKeyframe(0)
            LinearKeyframe(duration, duration: duration)
        }
    }
}

struct TestView: View {
    @State var tapTrigger: Int = 0
    @State var tapOrigin: CGPoint = .zero

    var body: some View {
        VStack {
            GeometryReader { _ in
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .circular)
                        .fill(.cyan.gradient.opacity(1.85))
                    Image(systemName: "person.3.fill")
                        .font(.system(size: 105))
                }
                .padding()
                .onTapGesture(coordinateSpace: .local) { tapLocation in
                    tapTrigger += 1
                    tapOrigin = tapLocation
                }
                .modifier(RippleEffect(trigger: tapTrigger, origin: tapOrigin))
            }
        }
    }
}

#Preview {
    TestView()
}
