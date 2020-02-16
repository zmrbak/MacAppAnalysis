//
//  NSObject+ReplaceMethod.m
//  mac13lib
//
//  Created by zmrbak on 2020/2/16.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import "NSObject+ReplaceMethod.h"

#import <AppKit/AppKit.h>
#import "objc/runtime.h"

@interface MyClass : NSObject
-(void)speak;

@end

@implementation NSObject (ReplaceMethod)
+ (void)zmChange
{
    Method originalMethod=class_getInstanceMethod(objc_getClass("MyClass"), @selector(speak));
    Method tobechangedMethod=class_getInstanceMethod([self class], @selector(mySpeak));
    if(originalMethod && tobechangedMethod)
    {
        method_exchangeImplementations(originalMethod, tobechangedMethod);
    }
    
}
-(void)mySpeak
{
    NSLog(@"======= NSObject (ReplaceMethod) =======");
    [self mySpeak];
}
@end
