# DDDebugView

[![LICENSE](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/dd2333/DDDebugView/blob/master/LICENSE)&nbsp;
[![SUPPORT](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)](https://en.wikipedia.org/wiki/IOS_7)&nbsp;
[![BLOG](https://img.shields.io/badge/blog-www.dd2333.com-orange.svg?style=flat)](http://www.dd2333.com)&nbsp;

  开启Debug模式，标记拦截事件的view并输出该view的信息.<br />

Usage
-----------------------------------
* Drag DDDebugView folder in your project.<br />

  ```#import "UIWindow+debug.h"```

### Open the Debug mode
    //Appdelegate.m
    
    #ifdef DEBUG
    + (void)load{
        [UIWindow hookWithPrintLog:YES];
    }
    #endif
    
Note
-----------------------------------
  Reference from BeeFramework
