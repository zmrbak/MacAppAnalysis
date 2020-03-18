//
//  AppDelegate.h
//  mac29A
//
//  Created by zmrbak on 2020/3/18.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class GCDAsyncSocket;

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    GCDAsyncSocket *asyncSocket;
}
@end

