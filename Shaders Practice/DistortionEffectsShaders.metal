//
//  DistortionEffectsShaders.metal
//  Shaders Practice
//
//  Created by Ayush Singhal on 05/05/24.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] float2 waveY(float2 position, float time){
    position.y += 5 * sin(5 * time + (position.y / 20));
    return position;
}

[[ stitchable ]] float2 relativeWave(float2 position, float time, float2 size){
    float2 distance = position / size;
    position.y += 5 * sin(5 * time + (position.y / 20)) * distance.x;
    return position;
}

float getNormalizedPosition(float curr, float prevStart, float prevEnd, float newStart, float newEnd)
{
    float oldAbsolutePosition = curr * (prevEnd - prevStart) + prevStart;
    float newNormalizedPosition = (oldAbsolutePosition - newStart) / (newEnd - newStart);
    return newNormalizedPosition;
}

// Dynamic Island animation
[[ stitchable ]] float2 dynamicIslandType(float2 position, float4 bounds, float progress){
    float2 size = float2(bounds[2], bounds[3]);

    // Normalize the current pixel position to a [0, 1] range.
    float2 p = position / size;

    // Pixels that are further away from the horizontal center should compress more.
    // The last two values `-1.0` and `1.0` control the amount of compression.
    float xOffset = getNormalizedPosition(p.x - 0.5, -0.5, 0.5, -1.0, 1.0);

    // Adjust the horizontal compression based on the pixel's y-coordinate.
    // This creates the asymmetric "squeeze" effect.
    xOffset *= (1.0 - p.y);

    // `xOffset` is normalized from [0, 1], so multiply it by the view's width to convert back to screen coordinates.
    float xOffsetDenormalized = xOffset * size.x;

    // Move card up and down based on the animation's `progress`.
    // When progress is 0, `yOffsetDenorm` is 0. When progress = 1, the translation is slightly larger than the screen's height.
    float yOffsetDenorm = size.y * 1.3 * progress;

    // De-normalize back to screen coordinates again.
    xOffsetDenormalized *= progress;

    // Return our adjusted coordinate for this pixel.
    return float2(position.x + xOffsetDenormalized, position.y + yOffsetDenorm);
}
