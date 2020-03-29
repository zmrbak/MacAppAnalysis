//
//  main.m
//  mac36
//
//  Created by zmrbak on 2020/3/29.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if(argc<2)
        {
            NSLog(@"参数不足！");
            return 0;
        }
        
        NSString* fileName=[[NSString alloc]initWithCString:argv[1] encoding:NSUTF8StringEncoding];
        if( ![[[fileName pathExtension] uppercaseString] isEqualToString:@"H"])
        {
            NSLog(@"文件扩展名不对！");
            return 0;
        }
        
        //把文件全部读出来，放到一个可变字符串中
        NSMutableString* fileContent=[[NSMutableString alloc]initWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
        //\n \r \r\n
        //处理回车换行
        [fileContent replaceOccurrencesOfString:@"\n" withString:@"\r" options:NSLiteralSearch range:NSMakeRange(0, [fileContent length])];
        [fileContent replaceOccurrencesOfString:@"\r\r" withString:@"\r" options:NSLiteralSearch range:NSMakeRange(0, [fileContent length])];
        
        //按行分割字符串
        NSArray* strArray=[fileContent componentsSeparatedByString:@"\r"];
        //类名
        NSMutableString* interfaceName=[[NSMutableString alloc]init];
        
        //找出类名，把所有的方法放在一个数组中
        NSMutableArray* originalMethodArray=[[NSMutableArray alloc]init];
        
        for (NSString* lineString in strArray) {
            //删除两端空白
            NSString* line=[lineString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            //空行
            if([line isEqualToString:@""]) continue;
            //注释行
            if([line hasPrefix:@"//"]) continue;
            //#
            if([line hasPrefix:@"#"]) continue;
            //- (id).cxx_construct;
            if([line hasSuffix:@".cxx_construct;"]) continue;
            //cxx_destruct
            if([line hasSuffix:@".cxx_destruct;"]) continue;
            //@class
            if([line hasPrefix:@"@class"]) continue;
            
            //类名
            if([line hasPrefix:@"@interface"])
            {
                NSUInteger len1=[@"@interface" length]+1;
                NSUInteger len2=[line length];
                NSString* tempString=[line substringWithRange:NSMakeRange(len1, len2-len1)];
                
                NSArray* tempArray=[tempString componentsSeparatedByString:@":"];
                interfaceName=[[tempArray[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];
                continue;
            }
            
            if([line hasPrefix:@"+"] || [line hasPrefix:@"-"])
            {
                [originalMethodArray addObject:line];
            }
        }
        
        //Hook方法前缀
        NSString* hookMethodPrefix=[[NSString alloc]initWithFormat:@"zm_%@_",interfaceName];
        //交换“类方法”的代码数组
        NSMutableArray* switchClassMethodArray=[[NSMutableArray alloc]init];
        //自己实现方法数组
        NSMutableArray* customMethodArray=[[NSMutableArray alloc]init];
        
        //遍历原始的方法数组
        for (NSString* item in originalMethodArray) {
            NSMutableString* orignalMethod=[[NSMutableString alloc]init];
            
            //此方法有参数
            if([item containsString:@":"])
            {
                //用冒号拆分形参
                NSArray* args=[item componentsSeparatedByString:@":"];
                for (int i=0; i<[args count]-1; i++) {
                    //再用空格拆分字符串
                    NSArray* method1=[args[i] componentsSeparatedByString:@" "];
                    NSArray* method2=[method1[[method1 count]-1 ] componentsSeparatedByString:@")"];
                    [orignalMethod appendString:method2[[method2 count]-1]];
                    [orignalMethod appendString:@":"];
                }
            }
            else{
                //没有参数，以)拆分
                NSArray* args=[item componentsSeparatedByString:@")"];
                //取最后一个元素
                orignalMethod=args[[args count]-1];
                orignalMethod= [[orignalMethod stringByReplacingOccurrencesOfString:@";" withString:@""] mutableCopy];
            }
            NSString* myHookMethod=[[NSString alloc]initWithFormat:@"exchangeMethod(objc_getClass(\"%@\"),@selector(%@),[NSObject class],@selector(%@),%@);",interfaceName,orignalMethod,[hookMethodPrefix stringByAppendingString:orignalMethod],[item hasPrefix:@"+"]? @"true":@"false"];
            [switchClassMethodArray addObject:myHookMethod];
            
            //准备构造自己实现的方法
            NSRange rang1= [item rangeOfString:@")"];
            NSMutableString* customMethod=[[item stringByReplacingCharactersInRange:NSMakeRange(rang1.location+1, 0) withString:hookMethodPrefix] mutableCopy];
            [customMethod deleteCharactersInRange:NSMakeRange([customMethod length]-1,1)];
            
            //构造函数体
            NSMutableString* customMethodInside=[customMethod mutableCopy];
            NSRange r0=[customMethodInside rangeOfString:@")"];
            [customMethodInside deleteCharactersInRange:NSMakeRange(0, r0.location+1)];
            
            //删除参数前面的参数声明
            while(true)
            {
                if([customMethodInside containsString:@")"])
                {
                    NSRange r1=[customMethodInside rangeOfString:@"("];
                    NSRange r2=[customMethodInside rangeOfString:@")"];
                    //删除做括号和右括号之间的内容
                    [customMethodInside deleteCharactersInRange:NSMakeRange(r1.location, r2.location-r1.location+1)];
                }
                else{
                    break;
                }
            }
            
            [customMethod appendString:@"{\r"];
            [customMethod appendFormat:@"return [self %@];",customMethodInside ];
            [customMethod appendString:@"\r}"];
            [customMethodArray addObject:customMethod];
        }
        
        for (NSString* item in switchClassMethodArray) {
            printf("%s\n\r",[item cStringUsingEncoding:NSUTF8StringEncoding]);
        }
        
        printf("\n\r");
        
        for (NSString* item in customMethodArray) {
            printf("%s\n\r",[item cStringUsingEncoding:NSUTF8StringEncoding]);
        }
    }
    return 0;
}
