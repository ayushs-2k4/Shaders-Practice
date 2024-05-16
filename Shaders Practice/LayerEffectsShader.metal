//
//  LayerEffectsShader.metal
//  Shaders Practice
//
//  Created by Ayush Singhal on 05/05/24.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] half4 loupe(float2 position, SwiftUI::Layer layer, float2 size, float2 touch)
{
    float maxDistance = 0.05;
    
    float2 uv = position / size;
    float2 centre = touch / size;
    float2 delta = uv - centre;
    float aspectRatio = size.x / size.y;
    
    float distance = (delta.x * delta.x + (delta.y / aspectRatio) * (delta.y / aspectRatio)) / 1;
    
    float totalZoom = 1;
    
    if (distance < maxDistance)
    {
        totalZoom /= 2;
    }
    
    float2 newPos = totalZoom * delta + centre;
    return  layer.sample(newPos * size);
}

[[ stitchable ]] half4 warpingLoupe(float2 position, SwiftUI::Layer layer, float2 size, float2 touch)
{
    float maxDistance = 0.05;
    
    float2 uv = position / size;
    float2 centre = touch / size;
    float2 delta = uv - centre;
    float aspectRatio = size.x / size.y;
    
    float distance = (delta.x * delta.x + (delta.y / aspectRatio) * (delta.y / aspectRatio)) / 1;
    
    float totalZoom = 1;
    
    if (distance < maxDistance)
    {
        totalZoom /= 2;
        
        totalZoom += distance * (10);
    }
    
    float2 newPos = totalZoom * delta + centre;
    return  layer.sample(newPos * size);
}
