//
//  Goods.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "Goods.h"

@implementation Goods

+(NSDictionary *)mj_objectClassInArray{
    return @{@"gid" : @"id"};
}

@end

@implementation GoodsData

+(void)loadGoodsData:(CompleteBlock)complete{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"首页新鲜热卖" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    GoodsData *goodsData = [GoodsData mj_objectWithKeyValues:json];
    if (goodsData) {
        complete(goodsData.data, nil);
    }
}

+(NSDictionary *)mj_objectClassInArray{
    return @{@"data":NSStringFromClass([Goods class])};
}
@end
