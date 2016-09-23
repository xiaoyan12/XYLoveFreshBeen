//
//  SuperMarketSource.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/23.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SuperMarketData;
@class Procucts;
@class ProductCategory;
@class Goods;

@interface SuperMarketSource : NSObject

@property (nonatomic ,copy) NSString *code;
@property (nonatomic ,copy) NSString *msg;
@property (nonatomic ,strong) SuperMarketData *data;

+(void)loadSupermarketData:(CompleteBlock)complete;

@end


@interface SuperMarketData : NSObject

@property (nonatomic ,strong)NSArray<ProductCategory *> *categories;
@property (nonatomic ,strong) id products;

@end

@interface ProductCategory : NSObject

@property (nonatomic ,copy) NSString *id;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *sort;
@property (nonatomic ,strong) NSArray *products;

@end
