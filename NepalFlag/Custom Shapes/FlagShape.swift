//
//  FlagShape.swift
//  NepalFlag
//
//  Created by Nirajan Shrestha on 19/08/2025.
//

import SwiftUI

/// references:
/// - https://mathjokes4mathyfolks.wordpress.com/2017/06/07/the-amazing-national-flag-of-nepal/
/// - https://ag.gov.np/files/Constitution-of-Nepal_2072_Eng_www.moljpa.gov_.npDate-72_11_16.pdf
/// - https://www.crwflags.com/fotw/flags/np-law.html

struct FlagShape: Shape {
	func path(in rect: CGRect) -> Path {
		Path { path in
			let size = rect.size

			// Define key points
			let pointA = CGPoint(x: rect.minX, y: rect.maxY)
			let pointB = CGPoint(x: rect.maxX, y: rect.maxY)
			let pointC = CGPoint(x: rect.minX, y: rect.minY)
			let pointD = CGPoint(x: rect.minX, y: size.height - size.width)

			// Calculate point E where BE = AB
			let pointE = calculatePointE(from: pointB, to: pointD, distance: rect.width)

			// Draw the shape as a single path
			path.move(to: pointA)
			path.addLine(to: pointB)      // AB
			path.addLine(to: pointE)      // BE
			path.addLine(to: CGPoint(x: rect.maxX, y: pointE.y))  // Horizontal from E to right edge
			path.addLine(to: pointC)      // Up to C
			path.closeSubpath()           // Back to A
		}
	}

	private func calculatePointE(from start: CGPoint, to end: CGPoint, distance: CGFloat) -> CGPoint {
		let dx = end.x - start.x
		let dy = end.y - start.y
		let totalDistance = sqrt(dx * dx + dy * dy)

		let unitX = dx / totalDistance
		let unitY = dy / totalDistance

		return CGPoint(
			x: start.x + unitX * distance,
			y: start.y + unitY * distance
		)
	}
}

struct OldLogicForFlagShape: Shape {
	func path(in rect: CGRect) -> Path {
		Path { path in
			let size = rect.size

			path.move(to: CGPoint(x: rect.minX, y: rect.minY))
			path.addLine(to: CGPoint(x: rect.maxX, y: size.height * 0.5))
			path.addLine(to: CGPoint(x: size.width * 0.4, y: size.height * 0.5))
			path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
			path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

			path.closeSubpath()
		}
	}
}
