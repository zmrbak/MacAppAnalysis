//
//  main.m
//  mac32
//
//  Created by zmrbak on 2020/3/19.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //NSDictionary
        //        NSMutableDictionary
        
        //        NSArray
        //        NSMutableArray
        
        NSMutableDictionary* d1=[[NSMutableDictionary alloc]init];
        [d1 setObject:@"v1" forKey:@"k1"];
        [d1 setObject:@"v2" forKey:@"k2"];
        [d1 setObject:@"v3" forKey:@"k3"];
        [d1 setObject:@"v4" forKey:@"k4"];
        [d1 setObject:@"v5" forKey:@"k5"];
        
        NSMutableArray* array=[[NSMutableArray alloc]init];
        [array addObject:d1];
        [array addObject:d1];
        [array addObject:d1];
        
        //        if([NSJSONSerialization isValidJSONObject:d1])
        //        {
        //            NSData* data= [NSJSONSerialization dataWithJSONObject:d1 options:NSJSONWritingSortedKeys error:nil];
        //            NSString* str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //            NSLog(@"%@",str);
        //        }
        //        if([NSJSONSerialization isValidJSONObject:array])
        //        {
        //            NSData* data= [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingSortedKeys error:nil];
        //            NSString* str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //            NSLog(@"%@",str);
        //        }
        
        NSMutableDictionary* d2=[[NSMutableDictionary alloc]init];
        [d2 setObject:d1 forKey:@"dict"];
        [d2 setObject:array forKey:@"array"];
        
        if([NSJSONSerialization isValidJSONObject:d2])
        {
            NSData* data= [NSJSONSerialization dataWithJSONObject:d2 options:(NSJSONWritingSortedKeys) error:nil];
            NSString* str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
        }
        
    }
    return 0;
}
