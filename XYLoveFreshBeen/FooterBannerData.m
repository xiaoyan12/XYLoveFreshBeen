//
//  FooterBannerData.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/24.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "FooterBannerData.h"

@implementation FooterBannerData

+(void)loadFootBannerData:(CompleteBlock)complete{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"footerBanner" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    FooterBannerData *footer = [FooterBannerData mj_objectWithKeyValues:json];
    complete(footer.data, nil);
}

+(NSDictionary *)mj_objectClassInArray{
    return @{@"data":NSStringFromClass([Activity class])};
}
@end
