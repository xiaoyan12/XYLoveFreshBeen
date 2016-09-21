//
//  Goods.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject

//商品ID
@property (nonatomic ,copy) NSString *gid;
//商品姓名
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *brand_id;
//超市价格
@property (nonatomic ,copy) NSString *market_price;
@property (nonatomic ,copy) NSString *cid;
@property (nonatomic ,copy) NSString *category_id;

@property (nonatomic ,copy) NSString *partner_price;
@property (nonatomic ,copy) NSString *brand_name;
@property (nonatomic ,copy) NSString *pre_img;
@property (nonatomic ,copy) NSString *pre_imgs;
//参数
@property (nonatomic ,copy) NSString *specifics;
@property (nonatomic ,copy) NSString *product_id;
@property (nonatomic ,copy) NSString *dealer_id;
//当前价格
@property (nonatomic ,copy) NSString *price;
//库存
@property (nonatomic )      NSInteger number;
//买一赠一
@property (nonatomic ,copy) NSString *pm_desc;
@property (nonatomic ,copy) NSString *img;
@property (nonatomic )      NSInteger had_pm;
//是不是精选 0：不是， 1：是
@property (nonatomic )      NSInteger is_xf;
//记录用户对商品添加次数
@property (nonatomic )      NSInteger userBuyNumber;

@end

@interface GoodsData : NSObject

@property (nonatomic ,copy) NSString *code;
@property (nonatomic ,copy) NSString *msg;
@property (nonatomic ,copy) NSArray<Goods *> *data;

+(void)loadGoodsData:(CompleteBlock)complete;

@end
