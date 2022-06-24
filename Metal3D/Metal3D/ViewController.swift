//
//  ViewController.swift
//  Metal3D
//
//  Created by MZ01-KYONGH on 2022/06/22.
//

import UIKit
import MetalKit

class ViewController: UIViewController {
    @IBOutlet weak var metalView: MTKView!
    
    var device: MTLDevice!
    var renderer: Renderer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewSize = self.view.bounds.size
        
        metalView.device = MTLCreateSystemDefaultDevice()
        device = metalView.device
        
        renderer = Renderer(device: device, viewSize: viewSize)

        metalView.clearColor = Colors.wenderlichGreen
        metalView.delegate = renderer
    }


}

