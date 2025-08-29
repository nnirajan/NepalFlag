//
//  Flag.swift
//  NepalFlag
//
//  Created by Nirajan Shrestha on 19/08/2025.
//

import SwiftUI

struct Flag: View {
	// MARK: - Configuration
	private struct FlagConfig {
		static let sunMoonSizeRatio: CGFloat = 0.4
		static let crescentOffsetRatio: CGFloat = 0.16
		static let starSizeRatio: CGFloat = 0.7
		static let moonYOffsetRatio: CGFloat = -0.22
		static let sunYOffsetRatio: CGFloat = 0.24
		static let paddingRatio: CGFloat = 0.05
	}

	@State private var startDate = Date()

	// MARK: - body
	var body: some View {
		ZStack(alignment: .leading) {
			flagPole()
				.zIndex(1)

			VStack {
				flagView

				Spacer()
			}
			.flagWave(windSpeed: 6, wavelength: 40, amplitude: 4)
//			.waveEffect(speed: 4, frequency: 40, amplitude: 4)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding()
	}

	// MARK: - flag pole
	@ViewBuilder
	private func flagPole() -> some View {
		ZStack(alignment: .top) {
			// Flagpole
			RoundedRectangle(cornerRadius: 4)
				.fill(Color.brown)
				.frame(width: 8)
				.shadow(color: .black.opacity(0.3), radius: 3, x: 2, y: 2)

			// Pole top cap
			Circle()
				.fill(Color.yellow)
				.frame(width: 20, height: 20)
				.shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
		}
	}

	// MARK: - flag view
	@ViewBuilder
	private var flagView: some View {
		GeometryReader { geometry in
			let flagSize = geometry.size

			ZStack(alignment: .leading) {
				FlagShape()
					.fill(.crimsonRed)
					.stroke(
						.powderBlue,
						style: StrokeStyle(
							lineWidth: 10
						),
						antialiased: false
					)

				moonView(flagSize: flagSize)
				
				sunView(flagSize: flagSize)
			}
		}
		.aspectRatio(CGSize(width: 3, height: 4), contentMode: .fit)
		.padding(.vertical, 35)
		.background(Color(.systemBackground))
//		.background(
//			Color(
//				UIColor { traitCollection in
//					traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.white
//				}
//			)
//		)
		.padding(.horizontal, 20)
	}

	// MARK: - moon view
	@ViewBuilder
	private func moonView(flagSize: CGSize) -> some View {
		let moonSize = min(flagSize.width, flagSize.height) * FlagConfig.sunMoonSizeRatio
		let crescentOffset = moonSize * FlagConfig.crescentOffsetRatio
		let starSize = moonSize * FlagConfig.starSizeRatio
		let moonYOffset = flagSize.height * FlagConfig.moonYOffsetRatio

		Circle()
			.fill(.himalayanWhite)
			.frame(width: moonSize, height: moonSize)
			.overlay(
				Circle()
					.frame(width: moonSize, height: moonSize)
					.offset(x: crescentOffset)
					.blendMode(.destinationOut)
			)
			.compositingGroup()
			.rotationEffect(.degrees(-90))
			.overlay(alignment: .bottom) {
				StarShape(numSegments: 28, innerRadiusRatio: 0.68)
					.fill(.himalayanWhite)
					.frame(width: starSize, height: starSize)
					.rotationEffect(.degrees(90))
					.offset(y: 3)
			}
			.clipShape(Circle())
			.padding(flagSize.width * FlagConfig.paddingRatio)
			.offset(y: moonYOffset)
	}

	// MARK: - sun view
	@ViewBuilder
	private func sunView(flagSize: CGSize) -> some View {
		let sunSize = min(flagSize.width, flagSize.height) * FlagConfig.sunMoonSizeRatio
		let sunYOffset = flagSize.height * FlagConfig.sunYOffsetRatio

		StarShape(innerRadiusRatio: 0.62)
			.fill(.himalayanWhite)
			.frame(width: sunSize, height: sunSize)
			.padding(flagSize.width * FlagConfig.paddingRatio)
			.offset(y: sunYOffset)
	}
}

#Preview {
	Flag()
}
