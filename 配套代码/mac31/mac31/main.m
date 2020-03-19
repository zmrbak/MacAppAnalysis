//
//  main.m
//  mac31
//
//  Created by zmrbak on 2020/3/19.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSURL* url= [NSURL URLWithString:@"https://map.baidu.com/?qt=subwayscity&t=1584607684937"];
        NSError* err=nil;
        NSString* str=[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&err];
        //        NSLog(@"%@",str);
        if(err ==nil)
        {
            NSDictionary* jsonDict=[NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&err];
            //            NSLog(@"%@",jsonDict);
            //            NSLog(@"%@",jsonDict[@"result"]);
            //            NSLog(@"%@",jsonDict[@"result"][@"type"]);
            //            NSLog(@"%@",jsonDict[@"subways_city"]);
            //             NSLog(@"%@",jsonDict[@"subways_city"][@"cities"]);
            
            NSArray* listArray=jsonDict[@"subways_city"][@"cities"];
            //            NSLog(@"%@",listArray);
            
            for (NSDictionary* dic in listArray) {
                //                NSLog(@"%@",dic);
                NSLog(@"%@ %@",dic[@"cn_name"],dic[@"cpre"]);
            }
        }
    }
    return 0;
}
