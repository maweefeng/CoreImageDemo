//
//  UIImage+.swift
//  CoreImageDemo
//
//  Created by 尚软科技 on 2020/12/26.
//

import UIKit
import CoreImage
extension UIImage{
    
    /// 应用滤镜生成图片
    /// - Returns: 生成之后的图片
    func fileterImage()->UIImage{
        
        //Listing 1 Creating a context in Core Image
        let context = CIContext()
        //Listing 2 Loading an image into CIImage
        if let input = CoreImage.CIImage(image: self){
            let sepiaCIImage = sepiaFilter(input, intensity:0.9)!
            
            guard let bloomCIImage = bloomFilter(sepiaCIImage, intensity:1, radius:10) else { return self }
            let outImage = context.createCGImage(bloomCIImage, from: bloomCIImage.extent)
            let returnImage = UIImage(cgImage: outImage!)

            return returnImage
        }
        
        return self



        
    }
    
    func sepiaFilter(_ input: CIImage, intensity: Double) -> CIImage?
    {
        let sepiaFilter = CIFilter(name:"CISepiaTone")
        sepiaFilter?.setValue(input, forKey: kCIInputImageKey)
        sepiaFilter?.setValue(intensity, forKey: kCIInputIntensityKey)
        return sepiaFilter?.outputImage
    }
    
    func bloomFilter(_ input:CIImage, intensity: Double, radius: Double) -> CIImage?
    {
        let bloomFilter = CIFilter(name:"CIBloom")
        bloomFilter?.setValue(input, forKey: kCIInputImageKey)
        bloomFilter?.setValue(intensity, forKey: kCIInputIntensityKey)
        bloomFilter?.setValue(radius, forKey: kCIInputRadiusKey)
        return bloomFilter?.outputImage
    }
    
}
