//
//  FooterBannerData.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/24.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Activity.h"

@interface FooterBannerData : NSObject

@property (nonatomic ,strong) NSString *code;
@property (nonatomic ,strong) NSString *msg;
@property (nonatomic ,strong) NSArray<Activity *> *data;

+(void)loadFootBannerData:(CompleteBlock)complete;

@end
