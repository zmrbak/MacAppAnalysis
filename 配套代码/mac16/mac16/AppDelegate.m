//
//  AppDelegate.m
//  mac16
//
//  Created by zmrbak on 2020/2/25.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import "AppDelegate.h"
#import "ClassA.h"
#import "Library1.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    ClassA *a=[[ClassA alloc]init];
    [a sayHello];
    
    Library1 *b=[[Library1 alloc]init];
    [b sayHello];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
