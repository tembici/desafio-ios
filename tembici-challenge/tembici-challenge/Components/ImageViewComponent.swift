//
//  ImageViewComponent.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import SwiftUI
import class Kingfisher.ImageCache
import struct Kingfisher.KFImage


/// Kingfisher component abstraction responsible for displaying images
struct ImageViewComponent: View {
    
    var targetSize = CGSize()
    var url: String?
    
    let screenSize = UIScreen.main.bounds
    
    init(url: String?, type: Constants.ImageType) {
        
        self.url = url
        switch type {
        case .bigPoster:
            self.targetSize = ImageSizeHelper.getSizeBigPoster()
        case .backdrop:
            self.targetSize = ImageSizeHelper.getSizeBackdrop()
        case .smallPoster:
            self.targetSize = ImageSizeHelper.getSizeSmallPoster()
        }
    }
    
    func gerUrlImage() -> String {
        guard let path = self.url else {
            return ""
        }
        return Constants.API.baseImageURL + path
    }
    
    var body: some View {
        
        KFImage(URL(string: gerUrlImage()))
            .cancelOnDisappear(true)
            .resizable()
            .onFailure { e in
                print("Error: \(e)")
            }
        .placeholder {
            HStack {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(10)
            }
            .foregroundColor(.gray)
        }
        .cancelOnDisappear(true)
        .aspectRatio(contentMode: .fill)
        .frame(width: self.targetSize.width, height: self.targetSize.height)
        .animation(.linear(duration: 0.4))
        
    }
}

struct CustomImageView_Previews: PreviewProvider {
    
    @State static var  urlImage = DataContants.sharedInstance.urlImage
    
    static var previews: some View {
        ImageViewComponent(url: urlImage,type: .bigPoster)
    }
}

