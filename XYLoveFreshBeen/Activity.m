//
//  Activity.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/20.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "Activity.h"

@implementation Activity

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"aid":@"id"};
}
@end

@implementation HeadResource

+(void)loadHeadData:(CompleteBlock)complete{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"首页焦点按钮" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    HeadResource *headResource  = [HeadResource mj_objectWithKeyValues:json];
    complete(headResource.data, nil);
}

@end

@implementation HeadData

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"focus" : NSStringFromClass([Activity class]),
             @"activities" : NSStringFromClass([Activity class]),
             @"icons" : NSStringFromClass([Activity class])
             };
}

@end
