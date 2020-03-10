//
//  main.m
//  WxTool
//
//  Created by zmrbak on 2020/3/7.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+WxHelper.h"

static void __attribute__((constructor)) initialize(void)
{
    NSLog(@"------- WxHelper loaded  ----------");
    [NSObject zmChange];
}
