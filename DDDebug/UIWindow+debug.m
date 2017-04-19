//
//  UIWindow+debug.m
//  DebugerDemo
//
//  Created by dd2333 on 14-10-8.
//  Copyright (c) 2014年 dd2333. All rights reserved.
//

#import "UIWindow+debug.h"
#import "DDDebugBorderView.h"
#import "DDDebugIndicatorView.h"
#import <objc/runtime.h>

#define NOTIFY_TOUCH_BEGAN @"notify.UIWindow.TOUCH_BEGAN"
#define NOTIFY_TOUCH_MOVED @"notify.UIWindow.TOUCH_MOVED"
#define NOTIFY_TOUCH_ENDED @"notify.UIWindow.TOUCH_ENDED"


@implementation UIWindow (debug)

static void (*__sendEvent)( id, SEL, UIEvent * );
static BOOL __isPrint = NO;

+ (void)hookWithPrintLog:(BOOL)isPrint{
    static BOOL __swizzled = NO;
    __isPrint = isPrint;
    if ( NO == __swizzled )
    {
        Method method;
        IMP implement;
        
        method = class_getInstanceMethod( [UIWindow class], @selector(sendEvent:) );
        __sendEvent = (void (*)( id, SEL, UIEvent * ))method_getImplementation( method );
        
        implement = class_getMethodImplementation( [UIWindow class], @selector(ddSendEvent:) );
        method_setImplementation( method, implement );
        
        __swizzled = YES;
    }
}

- (void)ddSendEvent:(UIEvent *)event
{
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    if ( self == keyWindow )
    {
        if ( UIEventTypeTouches == event.type )
        {
            NSSet * allTouches = [event allTouches];
            if ( 1 == [allTouches count] )
            {
                UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
                if ( 1 == [touch tapCount] )
                {
                    if ( UITouchPhaseBegan == touch.phase )
                    {
                        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TOUCH_BEGAN object:nil];
                        
                        DDDebugBorderView * borderView = [DDDebugBorderView new];
                        borderView.frame = touch.view.bounds;
                        if (__isPrint) {
                            NSLog(@"\n%@\n\n%@", [UIWindow getPresentedViewController],touch.view);
                        }
                        [touch.view addSubview:borderView];
                        [borderView startAnimation];
                    }
                    else if ( UITouchPhaseMoved == touch.phase )
                    {
                        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TOUCH_MOVED object:nil];
                    }
                    else if ( UITouchPhaseEnded == touch.phase || UITouchPhaseCancelled == touch.phase )
                    {
                        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TOUCH_ENDED object:nil];

                        DDDebugIndicatorView * indicatorView = [DDDebugIndicatorView new];
                        indicatorView.frame = CGRectMake( 0, 0, 50.0f, 50.0f );
                        indicatorView.center = [touch locationInView:keyWindow];
                        [keyWindow addSubview:indicatorView];
                        [indicatorView startAnimation];
                    }
                }
            }
        }
    }
    
    if ( __sendEvent )
    {
        __sendEvent( self, _cmd, event );
    }
}

+ (UIViewController *)getPresentedViewController{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }

    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController*)result selectedViewController];
    }else if ([result isKindOfClass:[UINavigationController class]]){
        result = [(UINavigationController*)result visibleViewController];
    }
    
    return result;
}


@end
