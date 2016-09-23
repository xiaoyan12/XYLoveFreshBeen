//
//  FlashViewController.h
//  LoveFreshBeen_OC
//
//  Created by 江科 on 16/3/1.
//  Copyright © 2016年 江科. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedAdressViewController.h"

@protocol FlashTableViewDelagate <NSObject>

- (void)didTableView:(UITableView *)tableView clickedAtIndexPath:(NSIndexPath*)indexPath;

@end

@interface FlashViewController : SelectedAdressViewController

@property (nonatomic,weak) id<FlashTableViewDelagate>delegate;

@end
