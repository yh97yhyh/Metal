//
//  Vertex.swift
//  Metal3D
//
//  Created by MZ01-KYONGH on 2022/06/22.
//

import Foundation

struct Vertex {
    var x, y, z: Float
    var r, g, b, a: Float
    
    func floatBuffer() -> [Float] {
        return [x, y, z, r, g, b, a]
    }
}
