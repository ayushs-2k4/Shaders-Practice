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
