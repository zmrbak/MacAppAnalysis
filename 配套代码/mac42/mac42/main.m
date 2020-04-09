//
//  main.m
//  mac42
//
//  Created by zmrbak on 2020/4/8.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        AppDelegate* app=[[AppDelegate alloc]init];
        app.webPort=8422;
        app.webRootPath=[[[[NSString alloc]initWithCString:argv[0] encoding:NSUTF8StringEncoding] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"WebRoot"];
        [app startServer];
        
        getchar();
    }
    return 0;
}
