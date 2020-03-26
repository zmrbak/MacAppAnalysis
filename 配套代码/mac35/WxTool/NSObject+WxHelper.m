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
#import "GetLoginQRCodeResponse.h"
#import "QRCodeLoginCGI.h"
#import "CAESCrypt.h"
//#import "LoginQRCodeNotify.h"

@implementation NSObject (WxHelper)
static SocketDelegate* mySocket;
static void exchangeMethod(Class classA,SEL methodA,Class classB,SEL methodB,bool isClassMethod) {
    
    Method originalMethod=nil;
    Method tobechangedMethod=nil;
    
    if(isClassMethod)
    {
        //     originalMethod=class_getClassMethod(objc_getClass("MMLogger"), @selector(logWithMMLogLevel: module: file: line: func: message:));
        //     tobechangedMethod=class_getClassMethod([NSObject class], @selector(zmMMLoggerLogWithMMLogLevel: module: file: line: func: message:));
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

+(void)zmChange
{
    //    mySocket= [[SocketDelegate alloc]init];
    
    //    Method originalMethod=class_getClassMethod(objc_getClass("GetLoginQRCodeResponse"), @selector(parseFromData:));
    //    Method tobechangedMethod=class_getClassMethod([self class], @selector(zmGetLoginQRCodeResponseParseFromData:));
    //    if(originalMethod && tobechangedMethod)
    //    {
    //        method_exchangeImplementations(originalMethod, tobechangedMethod);
    //    }
    
    exchangeMethod(objc_getClass("MMLogger"),@selector(logWithMMLogLevel: module: file: line: func: message:),
                   [NSObject class],@selector(zmMMLoggerLogWithMMLogLevel: module: file: line: func: message:),
                   true);
    
    exchangeMethod(objc_getClass("QRCodeLoginCGI"),@selector(handleNotify: withOpcode:),
                   [NSObject class],@selector(zm_QRCodeLoginCGI_handleNotify: withOpcode:),
                   false);
}
+ (void)zmMMLoggerLogWithMMLogLevel:(int)arg1 module:(const char *)arg2 file:(const char *)arg3 line:(int)arg4 func:(const char *)arg5 message:(id)arg6
{
    [self zmMMLoggerLogWithMMLogLevel:arg1 module:arg2 file:arg3 line:arg4 func:arg5 message:arg6];
    
    NSString* logString= [[NSString alloc]initWithFormat:@"\n LogLevel:\t%d\n module:\t%s\n file:\t%s\n line:\t%d\n func:\t%s\n message:\t%@",arg1,arg2,arg3,arg4,arg5,arg6];
    NSLog(@"%@",logString);
    //    [mySocket sendMessage:logString];
}
- (BOOL)zm_QRCodeLoginCGI_handleNotify:(id)arg1 withOpcode:(unsigned int)arg2
{
    id tempSelf=self;
    id r12 = [tempSelf qrNotifyDecodeKey] ;
    id rbx = [objc_getClass("CAESCrypt") AESDecryptWithKey:r12 Data:arg1];
    id rax = [objc_getClass("LoginQRCodeNotify") parseFromData:rbx];
    if([rax status]!=0)
    {
        ;
    }
    
    
    BOOL result=[self zm_QRCodeLoginCGI_handleNotify:arg1 withOpcode:arg2];
    return result;
}
//+ (id)zmGetLoginQRCodeResponseParseFromData:(id)arg1
//{
//    id result= [self zmGetLoginQRCodeResponseParseFromData:arg1];
//
//    if([result hasQrcode] && [result hasUuid])
//    {
//        NSMutableDictionary* dict=[[NSMutableDictionary alloc]init];
//        [dict setObject:@"ZM_RECIVED_QRCODE" forKey:@"action"];
//        [dict setObject:[NSNumber numberWithInt:[[NSDate date] timeIntervalSince1970]] forKey:@"datetime"];
//
//        NSMutableDictionary* data=[[NSMutableDictionary alloc]init];
//        [data setObject:[NSNumber numberWithInt:[result checkTime]] forKey:@"checkTime"];
//        [data setObject:[NSNumber numberWithInt:[result expiredTime]] forKey:@"expiredTime"];
//        [data setObject:[result uuid] forKey:@"uuid"];
//
//        [dict setObject:data forKey:@"data"];
//
//        [mySocket sendDictionary:dict];
//
//    }
//
//    return result;
//}

@end
