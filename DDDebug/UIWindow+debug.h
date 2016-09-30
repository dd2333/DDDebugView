//
//  UIWindow+debug.h
//  DebugerDemo
//
//  Created by dd2333 on 14-10-8.
//  Copyright (c) 2014年 dd2333. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (debug)

+ (void)hookWithPrintLog:(BOOL)isPrint;

@end
