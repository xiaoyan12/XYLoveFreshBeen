//
//  UserInfo.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "UserInfo.h"


@implementation UserInfo

+(instancetype)sharedInstance{
    static UserInfo *userInfo;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[UserInfo alloc]init];
        
        [AddressData loadAdressData:^(NSArray *allAdress, NSError *error) {
            if (allAdress != nil) {
                userInfo.allAdress = [allAdress mutableCopy];
                userInfo.defaultAddress = allAdress[0];
            }
        }];
    });
    return userInfo;
}

-(Address *)defaultAddress{
    return _defaultAddress;
}
@end
