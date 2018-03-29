//
//  UIImageView+AOP.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/6/13.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "UIImageView+AOP.h"

@implementation UIImageView (AOP)

+ (void)load {
    
    [[self class] aspect_hookSelector:@selector(sd_setImageWithURL:placeholderImage:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info,NSURL *url,UIImage *placeHolderImage) {
        
        UIImageView *imageView = [info instance];
        __weak UIImageView *weakImageView = imageView;
        
        [imageView sd_setImageWithURL:url placeholderImage:placeHolderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (image) {
                
                CGFloat imageViewScale = weakImageView.lh_width/weakImageView.lh_height;
                CGFloat imageScale = image.size.width/image.size.height;
                
                if (imageViewScale>imageScale) {
                    
                    image = [image imageByResizeToSize:CGSizeMake(weakImageView.lh_width, weakImageView.lh_width * image.size.height/image.size.width)];

                } else {
                    
                    image = [image imageByResizeToSize:CGSizeMake( weakImageView.lh_height * image.size.width/image.size.height, weakImageView.lh_height)];
                }
                
                
                [weakImageView setImage:[image imageByResizeToSize:CGSizeMake(weakImageView.lh_width, weakImageView.lh_height) contentMode:UIViewContentModeCenter]];
            }

        }];
        
    }
    error:NULL];
    
}

@end
