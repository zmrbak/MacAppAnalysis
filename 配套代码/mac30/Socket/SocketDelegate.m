//
//  AppDelegate.m
//  mac29A
//
//  Created by zmrbak on 2020/3/18.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import "SocketDelegate.h"
#import "GCDAsyncSocket.h"

@interface SocketDelegate ()<GCDAsyncSocketDelegate>
{
    int index;
    NSTimer* connectTimer;
}
@end

@implementation SocketDelegate
- (instancetype)init
{
    self = [super init];
    if (self) {
       asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        NSString *host = @"127.0.0.1";
        uint16_t port = 8421;
        NSLog(@"Connecting to \"%@\" on port %hu...", host, port);
        
        NSError *error = nil;
        if (![asyncSocket connectToHost:host onPort:port error:&error])
        {
            NSLog(@"Error connecting: %@", error);
        }
        else{
            NSLog(@"connected!");
            connectTimer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(longConnectionToSocket) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:connectTimer forMode:NSRunLoopCommonModes];
        }
        [asyncSocket readDataWithTimeout:-1 tag:0];
    }
    return self;
}

-(void)longConnectionToSocket
{
    NSString *heartBeat=@"HEARTBEAT";
    [asyncSocket writeData:[heartBeat dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    [asyncSocket writeData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:0];
}

- (void)sendMessage:(NSString *)msg {
    NSData* myData=[msg dataUsingEncoding:NSUTF8StringEncoding];
    [asyncSocket writeData:myData withTimeout:-1 tag:0];
    [asyncSocket writeData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:0];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Socket Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"socket:%p didConnectToHost:%@ port:%hu", sock, host, port);
    [asyncSocket readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"socket:%p didWriteDataWithTag:%ld", sock, tag);
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString* text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"didReadData:withTag:%ld ,%@", tag,text);
    [asyncSocket readDataWithTimeout:-1 tag:0];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"socketDidDisconnect:%p withError: %@", sock, err);
    asyncSocket=nil;
    [connectTimer invalidate];
    connectTimer=nil;
}
@end
