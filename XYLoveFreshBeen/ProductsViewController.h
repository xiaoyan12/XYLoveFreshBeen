//
//  ProductsViewController.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/23.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "BaseViewController.h"
#import "SuperMarketSource.h"
#import "FlashViewController.h"

@protocol ProductsDelagate <NSObject>

-(void)didEndDislayHeaderView:(NSInteger)section;
-(void)willDislayHeaderView:(NSInteger)section;

@end

@interface ProductsViewController : BaseViewController<FlashTableViewDelagate>

@property (nonatomic ,strong) SuperMarketData *superData;

@property (nonatomic ,weak) id<ProductsDelagate>delegate;

@end
