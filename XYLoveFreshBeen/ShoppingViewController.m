//
//  ShoppingViewController.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "ShoppingViewController.h"
#import "EmptyShopCarView.h"

@interface ShoppingViewController ()

@property (nonatomic ,strong) EmptyShopCarView *emptyUI;

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildEmptyUI];
    // Do any additional setup after loading the view.
}

-(void)buildEmptyUI{
    self.emptyUI = [[EmptyShopCarView alloc]init];
   // self.emptyUI.hidden = YES;
    [self.view addSubview:self.emptyUI];
    [self.emptyUI mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(170);
        make.centerY.equalTo(self.view).offset(-60);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
