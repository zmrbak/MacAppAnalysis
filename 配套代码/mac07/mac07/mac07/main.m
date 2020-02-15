//
//  main.m
//  mac07
//
//  Created by zmrbak on 2020/2/11.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <mach-o/loader.h>
int a;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"a的地址：%p",&a);
                
    }
    return 0;
}
