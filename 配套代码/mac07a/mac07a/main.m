//
//  main.m
//  mac07a
//
//  Created by zmrbak on 2020/2/11.
//  Copyright © 2020 zmrbak. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <mach-o/loader.h>
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        struct mach_header_64 currentHeader;
        FILE *fp;
        fp=fopen("mac07", "rb+");
        if(fp==NULL)
        {
            NSLog(@"文件打开失败！");
            return 0;
        }
        
        if(fread(&currentHeader, sizeof(currentHeader), 1, fp)==0)
        {
            NSLog(@"读取文件失败！");
            return 0;
        }
        
        if((currentHeader.flags & MH_PIE ) == 0)
        {
            currentHeader.flags |= MH_PIE;
            NSLog(@"设置 MH_PIE");
        }
        else
        {
            currentHeader.flags &= ~MH_PIE;
            NSLog(@"取消 MH_PIE");
        }
        
        fseek(fp, 0, SEEK_SET);
        
        if(fwrite(&currentHeader, sizeof(currentHeader), 1, fp)==0)
        {
            NSLog(@"写入失败！");
        }
        else
        {
            NSLog(@"写入成功！");
        }
        
        fclose(fp);
        
        
    }
    return 0;
}
