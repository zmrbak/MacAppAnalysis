//
//  main.m
//  WxTool
//
//  Created by zmrbak on 2020/3/7.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+WxHelper.h"
#import <AFNetworking/AFNetworking.h>

static void __attribute__((constructor)) initialize(void)
{
    NSLog(@"------- WxHelper loaded  ----------");
//    [NSObject zmChange];
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//
//    NSURL *URL = [NSURL URLWithString:@"http://127.0.0.1:8422/123.jpg"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        NSLog(@"File downloaded to: %@", filePath);
//    }];
//    [downloadTask resume];
    
    //file:///Users/zmrbak/Documents/123.jpg
   
     NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://127.0.0.1:8422/upload.html" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"/Users/zmrbak/Documents/123.jpg"] name:@"file" fileName:@"filename3.jpg" mimeType:@"image/jpeg" error:nil];
            } error:nil];

        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.responseSerializer= [AFHTTPResponseSerializer serializer];
        NSURLSessionUploadTask *uploadTask;
        uploadTask = [manager
                      uploadTaskWithStreamedRequest:request
                      progress:^(NSProgress * _Nonnull uploadProgress) {
                          // This is not called back on the main queue.
                          // You are responsible for dispatching to the main queue for UI updates
    //                      dispatch_async(dispatch_get_main_queue(), ^{
    //                          //Update the progress view
    //                          [progressView setProgress:uploadProgress.fractionCompleted];
    //                      });
            NSLog(@"%f",uploadProgress.fractionCompleted);
                      }
                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                          if (error) {
                              NSLog(@"Error: %@", error);
                          } else {
                              NSLog(@"%@ %@", response, [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
                          }
                      }];

        [uploadTask resume];
}
