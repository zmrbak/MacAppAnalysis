
#import <Cocoa/Cocoa.h>

@class HTTPServer;

@interface AppDelegate : NSObject {
   	HTTPServer *httpServer;
}
-(void)startServer;
@property(nonatomic,copy)NSString* webRootPath;
@property(nonatomic,assign)NSInteger webPort;
@end
