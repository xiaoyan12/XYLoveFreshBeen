//
//  UserShopCarTool.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "UserShopCarTool.h"
#import "NSString+Extension.h"

@implementation UserShopCarTool

+(instancetype)sharedInstance{
    static UserShopCarTool *shopCarTool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shopCarTool ==nil) {
            shopCarTool = [[UserShopCarTool alloc]init];
        }
    });
    return shopCarTool;
}

-(NSMutableArray<Goods *> *)shopCar{
    if (!_shopCar) {
        _shopCar = [NSMutableArray array];
    }
    return _shopCar;
}

#pragma mark --添加商品
-(void)addSupermarkProductToSHopCar:(Goods *)goods{
    for (Goods *obj in self.shopCar) {
        if (obj.gid == goods.gid) {
            return;
        }
    }
    [self.shopCar addObject:goods];
}
#pragma mark --删除商品
-(void)removeFromProductShopCar:(Goods *)goods{
    for (Goods *obj in self.shopCar) {
        if (goods.gid == obj.gid) {
            [self.shopCar removeObject:goods];
            [[NSNotificationCenter defaultCenter] postNotificationName:LFBShopCarBuyNumberDidChangeNotification object:self userInfo:nil];
            return;
        }
    }
}
#pragma mark --获取商品数量
-(NSInteger)getShopCarGoodsNumer{
    __block NSInteger count = 0;
    [self.shopCar enumerateObjectsUsingBlock:^(Goods * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        count += obj.userBuyNumber;
    }];
    return count;
}

#pragma mark --获取商品用价格

-(CGFloat)getShopCarGoodsPrice{
    __block CGFloat price = 0;
    [self.shopCar enumerateObjectsUsingBlock:^(Goods * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        price += [[obj.price cleanDecimalPointZear] doubleValue] * obj.userBuyNumber;
    }];
    return price;
}

-(BOOL)isEmpty{
    return self.shopCar.count == 0;
}
@end
