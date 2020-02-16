//
//  main.m
//  mac13
//
//  Created by zmrbak on 2020/2/16.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyClass.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MyClass *my=[[MyClass alloc]init];
        [my speak];
    }
    return 0;
}
