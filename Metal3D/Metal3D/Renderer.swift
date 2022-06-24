//
//  Renderer.swift
//  Metal3D
//
//  Created by MZ01-KYONGH on 2022/06/22.
//

import Foundation
import MetalKit

class Renderer: NSObject {
    
//    var objectToDraw: Triangle!
    var objectToDraw: Cube!
    var projectionMatrix: Matrix4!
    var viewSize: CGSize

    let device: MTLDevice
    let commandQueue: MTLCommandQueue
    
    var vertices: [Float] = [
        0, 1, 0,
        -1, -1, 0,
        1, -1, 0
    ]
    
    var pipelineState: MTLRenderPipelineState?
//    var vertexBuffer: MTLBuffer?
    
    init(device: MTLDevice, viewSize: CGSize) {
        self.device = device
        self.viewSize = viewSize
        commandQueue = device.makeCommandQueue()!
        super.init()
        buildModel()
        buildPipelineState()
    }
    
    private func buildModel() {
//        vertexBuffer = device.makeBuffer(bytes: vertices,
//                                         length: vertices.count * MemoryLayout<Float>.size,
//                                         options: [])
//        objectToDraw = Triangle(device: device)
        objectToDraw = Cube(device: device)
//        objectToDraw.positionX = -0.25
//        objectToDraw.rotationZ = Matrix4.degrees(toRad: 45)
//        objectToDraw.scale = 0.5
//        objectToDraw.positionY =  0.25
//        objectToDraw.positionZ = -0.25
//        objectToDraw.positionX = 0.0
//        objectToDraw.positionY =  0.0
//        objectToDraw.positionZ = -2.0
//        objectToDraw.rotationZ = Matrix4.degrees(toRad: 45);
//        objectToDraw.scale = 0.5
        
        projectionMatrix = Matrix4.makePerspectiveViewAngle(Matrix4.degrees(toRad: 85.0), aspectRatio: Float(viewSize.width / viewSize.height), nearZ: 0.01, farZ: 100.0)
    }
    
    private func buildPipelineState() {
        let library = device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "vertex_shader")
        let fragmentFunction = library?.makeFunction(name: "fragment_shader")
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
//        pipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        
        do {
            pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch let error as NSError {
            print("error : \(error.localizedDescription)")
        }
    }
    
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
              let pipelineState = pipelineState,
              let descriptor = view.currentRenderPassDescriptor else { return }
        
//        let commandBuffer = commandQueue.makeCommandBuffer()
//
//        let commandEncorder = commandBuffer?.makeRenderCommandEncoder(descriptor: descriptor)
//
//        commandEncorder?.setRenderPipelineState(pipelineState)
//        commandEncorder?.setVertexBuffer(vertexBuffer,
//                                         offset: 0,
//                                         index: 0)
//        commandEncorder?.drawPrimitives(type: .triangle,
//                                        vertexStart: 0,
//                                        vertexCount: vertices.count)
//        commandEncorder?.endEncoding()
//        commandBuffer?.present(drawble)
//        commandBuffer?.commit()
        
//        objectToDraw.render(commandQueue: commandQueue, pipelineState: pipelineState, drawable: drawble, clearColor: nil)
        
//        objectToDraw.render(commandQueue: commandQueue, pipelineState: pipelineState, drawable: drawable, projectionMatrix: projectionMatrix, clearColor: nil)
        
        let worldModelMatrix = Matrix4()
        worldModelMatrix.translate(0.0, y: 0.0, z: -7.0)
        worldModelMatrix.rotateAroundX(Matrix4.degrees(toRad: 25), y: 0.0, z: 0.0)
        
        objectToDraw.updateWithDelta(delta: 0.01)
        objectToDraw.render(commandQueue: commandQueue, pipelineState: pipelineState, drawable: drawable, parentModelViewMatrix: worldModelMatrix, projectionMatrix: projectionMatrix ,clearColor: nil)

    }
    
    
}
