//
//  UserInfo.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressData.h"
@interface UserInfo : NSObject

@property (nonatomic ,strong)NSMutableArray *allAdress;

@property (nonatomic ,strong) Address *defaultAddress;

+(instancetype)sharedInstance;

@end
