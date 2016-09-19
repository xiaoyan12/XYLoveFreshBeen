//
//  AddressData.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Address;

@interface AddressData : NSObject
@property (nonatomic  ) NSInteger code;
@property (nonatomic ,copy) NSString *msg;
@property (nonatomic ,copy)NSArray<Address *> *data;

+(void)loadAdressData:(CompleteBlock)complete;

@end

@interface Address : NSObject

@property (nonatomic ,copy) NSString *accept_name;
@property (nonatomic ,copy) NSString *telphone;
@property (nonatomic ,copy) NSString *province_name;
@property (nonatomic ,copy) NSString *city_name;
@property (nonatomic ,copy) NSString *address;
@property (nonatomic ,copy) NSString *lng;
@property (nonatomic ,copy) NSString *lat;
@property (nonatomic ,copy) NSString *gender;

@end
