//
//  Shaders.metal
//  Shaders Practice
//
//  Created by Ayush Singhal on 05/05/24.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 passthrough(float2 position, half4 color){
    return color;
}

[[stitchable]] half4 recolor(float2 position, half4 color){
    return half4(1, 0, 0, color.a);
}

[[stitchable]] half4 invertAlpha(float2 position, half4 color){
    return half4(1, 0, 0, 1 - color.a);
}

[[stitchable]] half4 gradient(float2 position, half4 color){
    return half4(
                 position.x/ position.y,
                 0,
                 position.y/ position.x,
                 color.a
                 );
}

[[stitchable]] half4 animatedGradient(float2 position, half4 color, float time){
    float angle = atan2(position.y, position.x) + time;
    
    return half4(
                 sin(angle),
                 sin(angle + 2),
                 sin(angle + 4),
                 color.a
                 );
}

[[stitchable]] half4 animatedSilverEffect(float2 position, half4 color, float time){
    float angle = atan2(position.y, position.x) + time;
    
    return half4(
                 sin(angle),
                 sin(angle),
                 sin(angle),
                 color.a
                 );
}


