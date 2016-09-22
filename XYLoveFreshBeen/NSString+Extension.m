//
//  NSString+Extension.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/22.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

-(NSString *)cleanDecimalPointZear{
    NSInteger offset = self.length - 1;
    while (offset > 0) {
        NSString *str = [self substringWithRange:NSMakeRange(offset, 1)];
        if ([str isEqualToString:@"0"] || [str isEqualToString:@"."]) {
            offset--;
        }else{
            break;
        }
    }
    return [self substringToIndex:offset + 1];
}

@end
