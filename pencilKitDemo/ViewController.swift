//
//  ViewController.swift
//  pencilKitDemo
//
//  Created by Joyson  on 09/06/20.
//  Copyright © 2020 mobishala. All rights reserved.
//

import UIKit
import PencilKit

class ViewController: UIViewController {
    
    let canvasView = PKCanvasView(frame: .zero)
    // creating some conflicts in dev
    let item:String = "dev branch"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(canvasView)
        
        NSLayoutConstraint.activate([
            canvasView.topAnchor.constraint(equalTo: self.view.topAnchor),
            canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setNavigationBar() {
            let saveItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveImage))
            
            let clearItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clear))
            
            let toggleItem = UIBarButtonItem(title: "Toggle Picker", style: .plain, target: self, action: #selector(togglePicker))
    
            self.navigationItem.rightBarButtonItems  = [saveItem,clearItem,toggleItem]
           
        
    }

    @objc func saveImage() {
        let image = canvasView.drawing.image(from: canvasView.drawing.bounds, scale: 1.0)
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
    }
    
    @objc func clear() {
        canvasView.drawing = PKDrawing()
    }
    
    @objc func togglePicker() {
        if canvasView.isFirstResponder{
            canvasView.resignFirstResponder()
        }else{
            canvasView.becomeFirstResponder()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard
            let window = view.window,
            let toolPicker = PKToolPicker.shared(for: window) else { return }

        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
}
