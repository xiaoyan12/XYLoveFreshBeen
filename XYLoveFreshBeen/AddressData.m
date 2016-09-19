//
//  AddressData.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "AddressData.h"

@implementation AddressData
+(void)loadAdressData:(CompleteBlock)complete{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"MyAdress" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    AddressData *adressData = [AddressData mj_objectWithKeyValues:dict];
    if (complete == nil) {
        complete(adressData.data,nil);
    }
}

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"data" :NSStringFromClass([Address class])
             };
}
@end

@implementation Address

@end
