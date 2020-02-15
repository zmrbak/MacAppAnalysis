//
//  main.m
//  mac11lib2
//
//  Created by zmrbak on 2020/2/15.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import <Foundation/Foundation.h>

static void __attribute__((constructor)) initialize(void)
{
    NSLog(@"=============DYLIB LOADED==================");
}

