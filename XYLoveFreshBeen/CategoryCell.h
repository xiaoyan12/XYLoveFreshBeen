//
//  CategoryCell.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/23.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperMarketSource.h"

@interface CategoryCell : UITableViewCell

@property (nonatomic ,strong) ProductCategory *categroies;

+(instancetype)cellWithTable:(UITableView *)tableView;

@end
