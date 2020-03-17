//
//  MySocketServer.m
//  mac29
//
//  Created by zmrbak on 2020/3/17.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import "MySocketServer.h"
#import "GCDAsyncSocket.h"


#define WELCOME_MSG  0
#define ECHO_MSG     1
#define WARNING_MSG  2

#define READ_TIMEOUT 15.0
#define READ_TIMEOUT_EXTENSION 10.0

#define FORMAT(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]

@interface MySocketServer ()<GCDAsyncSocketDelegate>

- (void)logError:(NSString *)msg;
- (void)logInfo:(NSString *)msg;
- (void)logMessage:(NSString *)msg;

@end

@implementation MySocketServer

- (id)init
{
    if((self = [super init]))
    {
        socketQueue = dispatch_queue_create("socketQueue", NULL);
        listenSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:socketQueue];
        connectedSockets = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}
- (void)logError:(NSString *)msg
{
    NSLog(@"logError:\t%@",msg);
}
- (void)logInfo:(NSString *)msg
{
    NSLog(@"logInfo:\t%@",msg);
}

- (void)logMessage:(NSString *)msg
{
    NSLog(@"logMessage:\t%@",msg);
}
- (void)start
{
    if (_port < 0 || _port > 65535)
    {
        _port = 0;
    }
    
    NSError *error = nil;
    if(![listenSocket acceptOnPort:_port error:&error])
    {
        [self logError:FORMAT(@"Error starting server: %@", error)];
        return;
    }
    
    [self logInfo:FORMAT(@"Echo server started on port %hu", [listenSocket localPort])];
}

- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    @synchronized(connectedSockets)
    {
        [connectedSockets addObject:newSocket];
    }
    
    NSString *host = [newSocket connectedHost];
    UInt16 port = [newSocket connectedPort];
    
    [self logInfo:FORMAT(@"Accepted client %@:%hu", host, port)];
    
    NSString *welcomeMsg = @"Welcome to the AsyncSocket Echo Server\r\n";
    NSData *welcomeData = [welcomeMsg dataUsingEncoding:NSUTF8StringEncoding];
    
    [newSocket writeData:welcomeData withTimeout:-1 tag:WELCOME_MSG];
    
    [newSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:READ_TIMEOUT tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    if (tag == ECHO_MSG)
    {
        [sock readDataToData:[GCDAsyncSocket CRLFData] withTimeout:READ_TIMEOUT tag:0];
    }
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSData *strData = [data subdataWithRange:NSMakeRange(0, [data length] - 2)];
    NSString *msg = [[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding];
    if (msg)
    {
        [self logMessage:msg];
    }
    else
    {
        [self logError:@"Error converting received data into UTF-8 String"];
    }
    
    NSData *myData=[[msg stringByAppendingString:@"...OK!"] dataUsingEncoding:NSUTF8StringEncoding];
    // Echo message back to client
    [sock writeData:myData withTimeout:-1 tag:ECHO_MSG];
}


- (NSTimeInterval)socket:(GCDAsyncSocket *)sock
shouldTimeoutReadWithTag:(long)tag
                 elapsed:(NSTimeInterval)elapsed
               bytesDone:(NSUInteger)length
{
    if (elapsed <= READ_TIMEOUT)
    {
        NSString *warningMsg = @"Are you still there?\r\n";
        NSData *warningData = [warningMsg dataUsingEncoding:NSUTF8StringEncoding];
        [sock writeData:warningData withTimeout:-1 tag:WARNING_MSG];
        return READ_TIMEOUT_EXTENSION;
    }
    return 0.0;
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    if (sock != listenSocket)
    {
        [self logInfo:FORMAT(@"Client Disconnected")];
        @synchronized(connectedSockets)
        {
            [connectedSockets removeObject:sock];
        }
    }
}

@end
