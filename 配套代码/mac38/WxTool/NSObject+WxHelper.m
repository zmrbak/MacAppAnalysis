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
    exchangeMethod(objc_getClass("MMLoginOneClickViewController"),@selector(viewDidAppear),[NSObject class],@selector(zm_MMLoginOneClickViewController_viewDidAppear),false);

    exchangeMethod(objc_getClass("MMLoginOneClickViewController"),@selector(resetOneClickView),[NSObject class],@selector(zm_MMLoginOneClickViewController_resetOneClickView),false);
}

- (void)zm_MMLoginOneClickViewController_viewDidAppear{
    [self zm_MMLoginOneClickViewController_viewDidAppear]; //14
    id tempSelf=self;
    [tempSelf onLoginButtonClicked:[tempSelf loginButton]];
}

- (void)zm_MMLoginOneClickViewController_resetOneClickView{
return [self zm_MMLoginOneClickViewController_resetOneClickView];//1 //8
}



@end
