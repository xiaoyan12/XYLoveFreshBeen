//
//  UserShopCarTool.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Goods.h"

@interface UserShopCarTool : NSObject

@property (nonatomic ,strong)NSMutableArray<Goods *> *shopCar;

+(instancetype)sharedInstance;
-(void)addSupermarkProductToSHopCar:(Goods *)goods;//添加商品到购物车
-(void)removeFromProductShopCar:(Goods *)goods;    //删除商品
-(CGFloat)getShopCarGoodsPrice;                    //得到购物车商品价格
-(NSInteger)getShopCarGoodsNumer;                  //得到购物车商品数量
-(BOOL)isEmpty;                                    //购物车是否为空

@end
