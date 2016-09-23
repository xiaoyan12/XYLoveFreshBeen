//
//  SuperMarketSource.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/23.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "SuperMarketSource.h"
#import "Goods.h"

@implementation SuperMarketSource

+(void)loadSupermarketData:(CompleteBlock)complete{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"supermarket" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    SuperMarketSource *source = [SuperMarketSource mj_objectWithKeyValues:json];
    SuperMarketData *superData = source.data;
    for (NSInteger i = 0; i < superData.categories.count; i++) {
        ProductCategory *catgeory = superData.categories[i];
        NSArray *productsArr = superData.products[catgeory.id];
        catgeory.products = [Goods mj_objectArrayWithKeyValuesArray:productsArr];
    }
    complete(superData, nil);
}
@end

@implementation SuperMarketData

+(NSDictionary *)mj_objectClassInArray{
    return @{@"categories":NSStringFromClass([ProductCategory class])};
}

@end

@implementation ProductCategory

+(NSDictionary *)mj_objectClassInArray{
    return @{@"products":NSStringFromClass([Goods class])};
}

@end
