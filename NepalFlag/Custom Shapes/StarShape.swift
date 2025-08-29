//
//  StarShape.swift
//  NepalFlag
//
//  Created by Nirajan Shrestha on 19/08/2025.
//

import SwiftUI

struct StarShape: Shape {
	var numSegments = 24
	var innerRadiusRatio: CGFloat = 0.4  // Changed from 0.7 to 0.4 for longer lines

	init(numSegments: Int = 24, innerRadiusRatio: CGFloat = 0.4) {
		self.numSegments = numSegments
		self.innerRadiusRatio = innerRadiusRatio
	}

	func path(in rect: CGRect) -> Path {
		Path { path in
			let outerRadius = min(rect.height, rect.width) / 2
			let innerRadius = outerRadius * innerRadiusRatio
			let center = CGPoint(x: rect.midX, y: rect.midY)
			let stepAngle = 2 * .pi / CGFloat(numSegments)

			path.move(to: CGPoint(x: rect.midX, y: rect.minY))

			for index in 0..<numSegments {
				let angle = CGFloat(index) * stepAngle
				let radius = index.isMultiple(of: 2) ? outerRadius : innerRadius

				let xOffset: CGFloat = radius * sin(angle)
				let yOffset = radius * cos(angle)

				path.addLine(to: CGPoint(x: center.x + xOffset, y: center.y - yOffset))
			}
			path.closeSubpath()
		}
	}
}
