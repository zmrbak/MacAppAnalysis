//
//  main.m
//  mac29
//
//  Created by zmrbak on 2020/3/17.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MySocketServer.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        MySocketServer* socketServer= [[MySocketServer alloc]init];
        socketServer.port=8421;
        [socketServer start];
        getchar();
    }
    return 0;
}
