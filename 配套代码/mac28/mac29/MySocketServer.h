//
//  MySocketServer.h
//  mac29
//
//  Created by zmrbak on 2020/3/17.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCDAsyncSocket;
NS_ASSUME_NONNULL_BEGIN

@interface MySocketServer : NSObject
{
    dispatch_queue_t socketQueue;
    GCDAsyncSocket *listenSocket;
    NSMutableArray *connectedSockets;
}

@property(assign,nonatomic)NSInteger port;
- (void)start;
@end

NS_ASSUME_NONNULL_END
