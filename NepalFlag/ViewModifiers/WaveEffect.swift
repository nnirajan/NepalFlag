//
//  WaveEffect.swift
//  NepalFlag
//
//  Created by Nirajan Shrestha on 19/08/2025.
//

import SwiftUI

// MARK: - Wave View Modifier
struct WaveEffect: ViewModifier {
	let speed: CGFloat
	let frequency: CGFloat
	let amplitude: CGFloat

	@State private var startDate = Date()

	func body(content: Content) -> some View {
		TimelineView(.animation) { context in
			let time = context.date.timeIntervalSince(startDate)

			content
				.drawingGroup()
				.visualEffect { (content, proxy) in
					content
						.distortionEffect(
							ShaderLibrary.wavenormal(
								.float(time),
								.float(speed),
								.float(frequency),
								.float(amplitude)
							),
							maxSampleOffset: .zero
						)
				}
		}
	}
}

/////// MARK: - View Extension
extension View {
	/// Applies a wave distortion effect to the view
	/// - Parameters:
	///   - speed: How fast the wave moves (default: 2.0)
	///   - frequency: Wave frequency - smaller values create wider waves (default: 30.0)
	///   - amplitude: Wave height in points (default: 15.0)
	///   - maxSampleOffset: Maximum offset for sampling (default: 200.0)
	func waveEffect(
		speed: CGFloat = 2.0,
		frequency: CGFloat = 30.0,
		amplitude: CGFloat = 15.0
	) -> some View {
		modifier(
			WaveEffect(
				speed: speed,
				frequency: frequency,
				amplitude: amplitude
			)
		)
	}
}

// MARK: - Flag Wave Modifier
struct FlagWaveModifier: ViewModifier {
	let windSpeed: Float
	let wavelength: Float
	let amplitude: Float
	@State private var startDate = Date()

	func body(content: Content) -> some View {
		TimelineView(.animation) { context in
			let time = context.date.timeIntervalSince(startDate)

			content
				.drawingGroup()
				.visualEffect { content, proxy in
					content
						.distortionEffect(
							ShaderLibrary.relativeWave(
								.float2(proxy.size),
								.float(time),
								.float(windSpeed),
								.float(wavelength),
								.float(amplitude)
							),
							maxSampleOffset: .zero
						)
				}
		}
	}
}

extension View {
	/// Applies a flag waving effect to the view
	/// - Parameters:
	///   - windSpeed: How fast the wind blows (higher = faster animation)
	///   - wavelength: How long each wave is (higher = smoother, longer waves)
	///   - amplitude: How dramatic the waving is (higher = more movement)
	func flagWave(windSpeed: Float = 5.0, wavelength: Float = 50, amplitude: Float = 5) -> some View {
		self.modifier(FlagWaveModifier(windSpeed: windSpeed, wavelength: wavelength, amplitude: amplitude))
	}
}
