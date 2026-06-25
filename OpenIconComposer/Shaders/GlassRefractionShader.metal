#include <metal_stdlib>
using namespace metal;

kernel void glass_refraction(texture2d<float, access::read> inTexture [[texture(0)]],
                             texture2d<float, access::write> outTexture [[texture(1)]],
                             uint2 gid [[thread_position_in_grid]]) {
    // Refraction implementation
}
