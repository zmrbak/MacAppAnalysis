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
        NSWindow* win=[tempSelf window];
        NSInteger winId=[win windowNumber];
        
        //延时
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //截屏的文件保存的位置
            NSString* destinationPath=[[NSString alloc]initWithFormat:@"/tmp/1.png"];
            
            //启动截屏程序
            //kCGWindowImageBoundsIgnoreFraming
            CGImageRef screenShot= CGWindowListCreateImage(CGRectNull,kCGWindowListOptionIncludingWindow,(CGWindowID)winId,kCGWindowImageBoundsIgnoreFraming);
            NSImage* img=[[NSImage alloc]initWithCGImage:screenShot size:NSZeroSize];
            CGImageRelease(screenShot);
            
            //继续处理
            NSData* data=[img TIFFRepresentation];
            [data writeToFile:destinationPath atomically:YES];
            NSLog(@"screencapture ok");
        });
    }
}

@end
