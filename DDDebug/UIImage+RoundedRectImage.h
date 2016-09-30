//
//  UIImage+RoundedRectImage.h
//  ECG
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 dd2333. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RoundedRectImage)

- (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;

@end
