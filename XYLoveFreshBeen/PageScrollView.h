//
//  PageScrollView.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/20.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageScrollView : UIView

@property (nonatomic ,copy) ClickCallback callback;

+(instancetype)pageScrollView:(NSArray<NSString *> *)images placeHolder:(UIImage *)placeHolderImage;

@end
