//
//  ShopCartCell.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/23.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"

@interface ShopCartCell : UITableViewCell

@property (nonatomic ,strong) Goods *goods;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
