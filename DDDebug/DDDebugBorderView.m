//
//  DDDebugBorderView.m
//  DebugerDemo
//
//  Created by dd2333 on 14-10-8.
//  Copyright (c) 2014年 dd2333. All rights reserved.
//

#import "DDDebugBorderView.h"

@implementation DDDebugBorderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self )
    {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        self.layer.borderWidth = 4.0f;
        self.layer.borderColor = [UIColor redColor].CGColor;
    }
    return self;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    self.layer.cornerRadius = self.superview.layer.cornerRadius;
}

- (void)startAnimation
{
    self.alpha = 1.0f;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(didAppearingAnimationStopped)];
    
    self.alpha = 0.0f;
    
    [UIView commitAnimations];
}

- (void)didAppearingAnimationStopped
{
    [self removeFromSuperview];
}

@end
