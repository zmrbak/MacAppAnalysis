//
//  NSObject+WxHelper.m
//  WxTool
//
//  Created by zmrbak on 2020/3/7.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import "NSObject+WxHelper.h"
#import <AppKit/AppKit.h>
#import "objc/runtime.h"
#import "MMLogger.h"
#import "SocketDelegate.h"
#import "MMLoginOneClickViewController.h"
#import "MMButton.h"


static void PostMouseEvent(CGMouseButton button, CGEventType type, CGPoint point, int64_t clickCount)
{
    CGEventSourceRef source = CGEventSourceCreate(kCGEventSourceStatePrivate);
    CGEventRef theEvent = CGEventCreateMouseEvent(source, type, point, button);
    CGEventSetIntegerValueField(theEvent, kCGMouseEventClickState, clickCount);
    CGEventSetType(theEvent, type);
    CGEventPost(kCGHIDEventTap, theEvent);
    CFRelease(theEvent);
    CFRelease(source);
}

@implementation NSObject (WxHelper)
static SocketDelegate* mySocket;
static void exchangeMethod(Class classA,SEL methodA,Class classB,SEL methodB,bool isClassMethod) {
    
    Method originalMethod=nil;
    Method tobechangedMethod=nil;
    
    if(isClassMethod){
        originalMethod=class_getClassMethod(classA, methodA);
        tobechangedMethod=class_getClassMethod(classB, methodB);
        
    }
    else{
        originalMethod=class_getInstanceMethod(classA, methodA);
        tobechangedMethod=class_getInstanceMethod(classB, methodB);
    }
    if(originalMethod && tobechangedMethod)
    {
        method_exchangeImplementations(originalMethod, tobechangedMethod);
    }
}

+ (void)zmMMLoggerLogWithMMLogLevel:(int)arg1 module:(const char *)arg2 file:(const char *)arg3 line:(int)arg4 func:(const char *)arg5 message:(id)arg6
{
    [self zmMMLoggerLogWithMMLogLevel:arg1 module:arg2 file:arg3 line:arg4 func:arg5 message:arg6];
    NSString* logString= [[NSString alloc]initWithFormat:@"\n LogLevel:\t%d\n module:\t%s\n file:\t%s\n line:\t%d\n func:\t%s\n message:\t%@",arg1,arg2,arg3,arg4,arg5,arg6];
    NSLog(@"%@",logString);
    //    [mySocket sendMessage:logString];
}

+(void)zmChange
{
    //HOOK输出日志
    exchangeMethod(objc_getClass("MMLogger"),@selector(logWithMMLogLevel: module: file: line: func: message:),[NSObject class],@selector(zmMMLoggerLogWithMMLogLevel: module: file: line: func: message:),true);
    //HOOK的其它方法
    exchangeMethod(objc_getClass("MMButton"),@selector(drawRect:),[NSObject class],@selector(zm_MMButton_drawRect:),false);
    
}

- (void)zm_MMButton_drawRect:(struct CGRect)arg1{
   [self zm_MMButton_drawRect:arg1];

    id tempSelf=self;
    
    //把MMButton转换成NSButton
    NSButton* unlinkButton=tempSelf;
    
    //计算坐标
    if([[unlinkButton title] isEqualToString:@"切换帐号"])
    {
        //取得当前按钮的坐标
        NSRect buttonRect=[unlinkButton frame];
        
        //计算窗口大小
        NSRect screenRect= [[NSScreen mainScreen] frame];
        
        //取得窗口位置坐标
        NSRect winRect=[[tempSelf window] frame];
        
        //计算按钮中心位置
        CGPoint buttonConterPoint=NSMakePoint(winRect.origin.x+buttonRect.origin.x+buttonRect.size.width/2,                                            screenRect.size.height-(  winRect.origin.y+buttonRect.origin.y+buttonRect.size.height/2));
        
        double delay=1.0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //点击鼠标
            PostMouseEvent(kCGMouseButtonLeft , kCGEventLeftMouseDown, buttonConterPoint, 1);
            PostMouseEvent(kCGMouseButtonLeft , kCGEventLeftMouseUp, buttonConterPoint, 1);
        });
    }
}

@end
