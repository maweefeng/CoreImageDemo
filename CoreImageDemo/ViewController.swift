//
//  ViewController.swift
//  CoreImageDemo
//
//  Created by 尚软科技 on 2020/12/26.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    let imageView = UIImageView()
    let scrollView = UIScrollView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.frame = self.view.bounds
        scrollView.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(scrollView)
        scrollView.maximumZoomScale = 2
        scrollView.minimumZoomScale = 1/5
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickTwice))
        tap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(tap)
        if let image = UIImage(named: "penguin")?.fileterImage(){
            imageView.image = image
        }
        imageView.sizeToFit()
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.bounds.size
        
        let visulRect =  self.imageView.convert(self.imageView.frame, to: scrollView)
        scrollView.zoom(to: visulRect, animated: false)
        
    }
    
    @objc func clickTwice(){
        if scrollView.zoomScale >= 2.0  {
            scrollView.setZoomScale(1.0, animated: false)
            let visulRect =  self.imageView.convert(self.imageView.frame, to: scrollView)
            scrollView.zoom(to: visulRect, animated: true)
        }else{
            scrollView.setZoomScale(2.0, animated: true)
        }
 
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        let offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
        
        let offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
        
        self.imageView.center = CGPoint(x: scrollView.contentSize.width/2 + offsetX,y: scrollView.contentSize.height/2 + offsetY);
        
        
    }
}

