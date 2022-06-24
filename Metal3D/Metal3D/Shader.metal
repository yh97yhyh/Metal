//
//  Shader.metal
//  Metal3D
//
//  Created by MZ01-KYONGH on 2022/06/22.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    packed_float3 position;
    packed_float4 color;
};

struct VertexOut {
    float4 position [[position]];
    float4 color;
};

//struct Uniforms {
//  float4x4 modelMatrix;
//};
struct Uniforms {
    float4x4 modelMatrix;
    float4x4 projectionMatrix;
};


//vertex float4 vertex_shader(const device packed_float3 *vertices [[ buffer(0)]],
//                            uint vertexId [[ vertex_id ]]) {
//    return float4(vertices[vertexId], 1);
//}

//vertex VertexOut vertex_shader(const device VertexIn* vertex_array [[ buffer(0) ]],
//                               unsigned int vid [[ vertex_id ]]) {
//
//  VertexIn VertexIn = vertex_array[vid];
//
//  VertexOut VertexOut;
//  VertexOut.position = float4(VertexIn.position, 1);
//  VertexOut.color = VertexIn.color;
//
//  return VertexOut;
//}

vertex VertexOut vertex_shader(const device VertexIn* vertex_array [[ buffer(0) ]],
                               const device Uniforms&  uniforms    [[ buffer(1) ]],
                               unsigned int vid [[ vertex_id ]]) {
    
    float4x4 mv_Matrix = uniforms.modelMatrix;
    float4x4 proj_Matrix = uniforms.projectionMatrix;
    
    
    VertexIn VertexIn = vertex_array[vid];
    
    VertexOut VertexOut;
//    VertexOut.position = mv_Matrix * float4(VertexIn.position,1);
    VertexOut.position = proj_Matrix * mv_Matrix * float4(VertexIn.position,1);
    VertexOut.color = VertexIn.color;
    
    return VertexOut;
}

//fragment half4 fragment_shader()  {
//    return half4(1, 1, 1, 1);
//}

fragment half4 fragment_shader(VertexOut interpolated [[stage_in]]) {
    return half4(interpolated.color[0], interpolated.color[1], interpolated.color[2], interpolated.color[3]);
}


