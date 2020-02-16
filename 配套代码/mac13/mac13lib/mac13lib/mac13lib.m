//
//  mac13lib.m
//  mac13lib
//
//  Created by zmrbak on 2020/2/16.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ReplaceMethod.h"

static void __attribute__((constructor)) initialize(void)
{
    NSLog(@"------- mac13lib loaded  ----------");
    [NSObject zmChange];
}
