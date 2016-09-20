//
//  AddressCell.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressData.h"

typedef void(^ModifyCallback)(NSInteger tag);
@interface AddressCell : UITableViewCell

@property (nonatomic ,strong) Address *address;

+(instancetype)cellWithTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath callbackBlock:(ModifyCallback)callback;

@end
