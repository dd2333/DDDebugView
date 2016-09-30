//
//  DDDebugIndicatorView.m
//  DebugerDemo
//
//  Created by dd2333 on 14-10-8.
//  Copyright (c) 2014年 dd2333. All rights reserved.
//

#import "DDDebugIndicatorView.h"

@implementation DDDebugIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self )
    {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        self.contentMode = UIViewContentModeCenter;
        self.image = [UIImage imageNamed:@"tap.png"];
    }
    return self;
}

- (void)startAnimation
{
    self.alpha = 1.0f;
    self.transform = CGAffineTransformMakeScale( 0.5f, 0.5f );
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.6f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(didAppearingAnimationStopped)];
    
    self.alpha = 0.0f;
    self.transform = CGAffineTransformIdentity;
    
    [UIView commitAnimations];
}

- (void)didAppearingAnimationStopped
{
    [self removeFromSuperview];
}

@end
