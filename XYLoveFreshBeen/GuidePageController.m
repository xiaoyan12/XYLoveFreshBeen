//
//  GuidePageController.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/18.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "GuidePageController.h"
#import "GuideCell.h"

@interface GuidePageController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic ,strong)NSArray *guideImages;
@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic ,strong) UIPageControl *pageControl;

@end

static NSString *cellID = @"cellId";

@implementation GuidePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.guideImages = @[@"guide_40_1",@"guide_40_2",@"guide_40_3",@"guide_40_4"];
    
    // Do any additional setup after loading the view.
}

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(XYWidth, XYHeight);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        _collectionView.showsVerticalScrollIndicator = false;
        _collectionView.showsHorizontalScrollIndicator = false;
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GuideCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _collectionView;
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
