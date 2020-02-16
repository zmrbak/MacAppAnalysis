//
//  MyClass.h
//  mac14
//
//  Created by zmrbak on 2020/2/16.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyClass : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger number;
+ (void)methodA;
- (void)methodB;
+ (NSInteger)methodC:(NSInteger) numberC;
- (NSString *)methodD:(NSString *)stringD;
@end

NS_ASSUME_NONNULL_END
