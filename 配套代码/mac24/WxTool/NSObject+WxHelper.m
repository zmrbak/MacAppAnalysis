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


@interface GetLoginQRCodeResponse : NSObject
{
    unsigned int hasBaseResponse:1;
    unsigned int hasQrcode:1;
    unsigned int hasUuid:1;
    unsigned int hasCheckTime:1;
    unsigned int hasNotifyKey:1;
    unsigned int hasExpiredTime:1;
    unsigned int hasBlueToothBroadCastUuid:1;
    unsigned int hasBlueToothBroadCastContent:1;
    unsigned int checkTime;
    unsigned int expiredTime;
    //BaseResponse *baseResponse;
    //SKBuiltinBuffer_t *qrcode;
    NSString *uuid;
    //SKBuiltinBuffer_t *notifyKey;
    NSString *blueToothBroadCastUuid;
    //SKBuiltinBuffer_t *blueToothBroadCastContent;
}

+ (id)parseFromData:(id)arg1;
//@property(retain, nonatomic, setter=SetBlueToothBroadCastContent:) SKBuiltinBuffer_t *blueToothBroadCastContent; // @synthesize blueToothBroadCastContent;
@property(readonly, nonatomic) BOOL hasBlueToothBroadCastContent; // @synthesize hasBlueToothBroadCastContent;
@property(retain, nonatomic, setter=SetBlueToothBroadCastUuid:) NSString *blueToothBroadCastUuid; // @synthesize blueToothBroadCastUuid;
@property(readonly, nonatomic) BOOL hasBlueToothBroadCastUuid; // @synthesize hasBlueToothBroadCastUuid;
@property(nonatomic, setter=SetExpiredTime:) unsigned int expiredTime; // @synthesize expiredTime;
@property(readonly, nonatomic) BOOL hasExpiredTime; // @synthesize hasExpiredTime;
//@property(retain, nonatomic, setter=SetNotifyKey:) SKBuiltinBuffer_t *notifyKey; // @synthesize notifyKey;
@property(readonly, nonatomic) BOOL hasNotifyKey; // @synthesize hasNotifyKey;
@property(nonatomic, setter=SetCheckTime:) unsigned int checkTime; // @synthesize checkTime;
@property(readonly, nonatomic) BOOL hasCheckTime; // @synthesize hasCheckTime;
@property(retain, nonatomic, setter=SetUuid:) NSString *uuid; // @synthesize uuid;
@property(readonly, nonatomic) BOOL hasUuid; // @synthesize hasUuid;
//@property(retain, nonatomic, setter=SetQrcode:) SKBuiltinBuffer_t *qrcode; // @synthesize qrcode;
@property(readonly, nonatomic) BOOL hasQrcode; // @synthesize hasQrcode;
//@property(retain, nonatomic, setter=SetBaseResponse:) BaseResponse *baseResponse; // @synthesize baseResponse;
@property(readonly, nonatomic) BOOL hasBaseResponse; // @synthesize hasBaseResponse;
//- (void).cxx_destruct;
- (id)mergeFromCodedInputStream:(id)arg1;
- (int)serializedSize;
- (void)writeToCodedOutputStream:(id)arg1;
- (BOOL)isInitialized;
- (id)init;
@end


@implementation NSObject (WxHelper)
+(void)zmChange
{
    NSBundle *main = [NSBundle mainBundle];
    NSDictionary *dict=[main infoDictionary];
    for (NSString* key in dict) {
        NSString* value=dict[key];
        NSLog(@"key = %@ , value = %@",key,value);
        
        //获取版本
        //CFBundleShortVersionString
        //CFBundleVersion
    }
    ;
    
//    Method originalMethod=class_getClassMethod(objc_getClass("GetLoginQRCodeResponse"), @selector(parseFromData:));
//    Method tobechangedMethod=class_getClassMethod([self class], @selector(zmGetLoginQRCodeResponseParseFromData:));
//    if(originalMethod && tobechangedMethod)
//    {
//        method_exchangeImplementations(originalMethod, tobechangedMethod);
//    }
}

+ (id)zmGetLoginQRCodeResponseParseFromData:(id)arg1
{
    id result= [self zmGetLoginQRCodeResponseParseFromData:arg1];

    NSLog(@"hasBaseResponse:\t %d",[result hasBaseResponse]);
    NSLog(@"hasQrcode:\t %d",[result hasQrcode]);
    NSLog(@"hasUuid:\t %d",[result hasUuid]);
    NSLog(@"hasCheckTime:\t %d",[result hasCheckTime]);
    NSLog(@"hasNotifyKey:\t %d",[result hasNotifyKey]);
    NSLog(@"hasExpiredTime:\t %d",[result hasExpiredTime]);
    NSLog(@"hasBlueToothBroadCastUuid:\t %d",[result hasBlueToothBroadCastUuid]);
    NSLog(@"hasBlueToothBroadCastContent:\t %d",[result hasBlueToothBroadCastContent]);
    NSLog(@"checkTime:\t %d",[result checkTime]);
    NSLog(@"expiredTime:\t %d",[result expiredTime]);
    NSLog(@"uuid:\t %@",[result uuid]);
    NSLog(@"blueToothBroadCastUuid:\t %@",[result blueToothBroadCastUuid]);
    
    return result;
}

@end
