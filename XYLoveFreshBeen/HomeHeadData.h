//
//  HomeHeadData.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/20.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Activity.h"
#import "Goods.h"
@class ActInfo;
@class ActRow;
@class HeadlinDetail;
@class CategoryDetail;


@interface HomeHeadData : NSObject

@property (nonatomic ,copy) NSArray<ActInfo *> *act_info;
@property (nonatomic ,strong) ActInfo *focus;
@property (nonatomic ,strong) ActInfo *icon;
@property (nonatomic ,strong) ActInfo *headline;
@property (nonatomic ,strong) ActInfo *brand;
@property (nonatomic ,strong) ActInfo *scene;
@property (nonatomic ,strong) ActInfo *category;

+(void)loadHeadData:(CompleteBlock)complete;

@end

@interface ActInfo : NSObject

@property (nonatomic ,strong)NSString *sort;
@property (nonatomic ,strong)NSString *type;
@property (nonatomic ,strong)NSString *head_img;
@property (nonatomic ,strong)NSArray<ActRow *> *act_rows;

@end

@interface ActRow : NSObject

@property (nonatomic ,strong) Activity *activity;
@property (nonatomic ,strong) HeadlinDetail *headline_detail;
@property (nonatomic ,strong) CategoryDetail *category_detail;

@end

@interface HeadlinDetail : NSObject

@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *content;

@end

@interface CategoryDetail : NSObject

@property (nonatomic ,strong)NSString *catgory_id;
@property (nonatomic ,strong)NSString *name;
@property (nonatomic ,strong)NSArray<Goods *> *goods;
@property (nonatomic ,strong)NSString *category_color;

@end
