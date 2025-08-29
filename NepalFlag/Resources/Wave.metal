//
//  Wave.metal
//  NepalFlag
//
//  Created by Nirajan Shrestha on 19/08/2025.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

// for flag wave form the middle
// Flag wave shader - creates a waving effect from the leading edge
[[ stitchable ]] float2 relativeWave(float2 position, float2 size, float time, float windSpeed, float wavelength, float amplitude) {
	// Calculate our coordinate in UV space, 0 to 1, with slight scaling
	half2 uv = half2(position / size);

	// Create wave offset using sine wave
	// time * windSpeed controls how fast the wind blows
	// position.x / wavelength controls how long each wave is
	half offset = sin(time * windSpeed + position.x / wavelength);

	// Apply wave amplitude based on distance from left edge (flag pole)
	// uv.x gives us 0 at left edge, 1 at right edge
	// This creates the flag waving effect where movement increases toward the free edge
	position.y += offset * uv.x * amplitude;

	// Send back the offset position
	return position;
}

// working
[[ stitchable ]] float2 wavenormal(float2 position, float time, float speed, float frequency, float amplitude) {
	float positionY = position.y + sin((time * speed) + (position.x / frequency)) * amplitude;

	return float2(position.x, positionY);
}


// Wave animation starting from the middle of the flag
[[ stitchable ]] float2 wave(float2 position, float2 size, float time, float speed, float frequency, float amplitude) {
	// Calculate distance from the middle of the flag (normalized 0-1)
	float middleX = size.x * 0.5;
	float distanceFromMiddle = abs(position.x - middleX) / middleX;

	// Wave intensity increases with distance from middle
	float waveIntensity = distanceFromMiddle;

	// Calculate wave displacement
	float wave = sin((time * speed) + (position.x / frequency)) * amplitude * waveIntensity;

	// Apply wave to Y position
	float positionY = position.y + wave;

	return float2(position.x, positionY);
}

// Alternative version with smoother falloff from middle
[[ stitchable ]] float2 waveSmooth(float2 position, float2 size, float time, float speed, float frequency, float amplitude) {
	// Calculate normalized distance from middle (0 at center, 1 at edges)
	float middleX = size.x * 0.5;
	float distanceFromMiddle = abs(position.x - middleX) / middleX;

	// Smooth curve for wave intensity (quadratic falloff from middle)
	float waveIntensity = distanceFromMiddle * distanceFromMiddle;

	// Multiple wave frequencies for more natural motion
	float wave1 = sin((time * speed) + (position.x / frequency)) * amplitude * waveIntensity;
	float wave2 = sin((time * speed * 1.3) + (position.x / (frequency * 0.7))) * amplitude * 0.3 * waveIntensity;

	float totalWave = wave1 + wave2;
	float positionY = position.y + totalWave;

	return float2(position.x, positionY);
}
