//
//  MyClass.m
//  mac14
//
//  Created by zmrbak on 2020/2/16.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import "MyClass.h"

@implementation MyClass
+ (void)methodA
{
    NSLog(@"methodA");
}
- (void)methodB
{
    NSLog(@"methodB");
}
+ (NSInteger)methodC:(NSInteger) numberC
{
    return numberC;
}
- (NSString *)methodD:(NSString *)stringD
{
    return stringD;
}
@end
