//
//  HomeCell.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/21.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
#import "Goods.h"

typedef NS_ENUM(NSInteger, HomeCellType){
    HomeCellTypeVertical,
    HomeCellTypeHorizontal
};

@interface HomeCell : UICollectionViewCell

@property (nonatomic ,strong) Goods *goods;
@property (nonatomic ,strong) Activity *activity;
@property (nonatomic )        BOOL buyViewShowZear;

@end
