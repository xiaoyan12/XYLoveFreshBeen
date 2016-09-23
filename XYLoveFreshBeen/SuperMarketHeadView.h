//
//  SuperMarketHeadView.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/23.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperMarketHeadView : UITableViewHeaderFooterView

@property (nonatomic ,strong) NSString *title;

+(instancetype)headerCellWith:(UITableView *)tableView;

@end
