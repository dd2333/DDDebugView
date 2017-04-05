# 

[![github](https://github.com/dd2333/DDPhotoAlbum/blob/master/dd2333.png "dd2333")](http://www.dd2333.com)

DDDebugView
===================================
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

License
-----------------------------------
  DDDebugView is released under the MIT license.<br />
