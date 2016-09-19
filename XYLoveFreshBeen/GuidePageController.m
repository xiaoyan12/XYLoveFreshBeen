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
    
   [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
   
    [self setUpThePageControl];
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
        
        [_collectionView registerClass:[GuideCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.guideImages.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.image = [UIImage imageNamed:self.guideImages[indexPath.row]];
    
    if (indexPath.row == self.guideImages.count - 1) {
        [cell setNextButtonHidden:false];
    }else{
        [cell setNextButtonHidden:true];
    }
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = (scrollView.contentOffset.x + self.view.frame.size.width * 0.5)/ self.view.frame.size.width;
    self.pageControl.currentPage = index;
}

-(void)setUpThePageControl{
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.numberOfPages = self.guideImages.count;
    self.pageControl.currentPage = 0;
    //先添加视图到View上，在进行用Masonry布局；
    [self.view addSubview:self.pageControl];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo(20);
        make.leading.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-50);
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
