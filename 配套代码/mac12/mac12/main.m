//
//  main.m
//  mac12
//
//  Created by zmrbak on 2020/2/16.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Speak.h"
#import "Animal.h"
#import "Dog.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //Animal -> NSObject -> NSObject(Speak)
        Animal *a=[[Animal alloc]init];
        [a bark];
        
        //Dog  -> Animal -> NSObject -> NSObject(Speak)
        Dog *d=[[Dog alloc]init];
        [d bark];
        
        //NSString -> NSObject -> NSObject(Speak)
        NSString *c=@"ccc";
        [c bark];
        
    }
    return 0;
}
