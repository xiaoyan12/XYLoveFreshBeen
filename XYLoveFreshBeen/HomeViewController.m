//
//  HomeViewController.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeadView.h"
#import "Goods.h"
#import "HomeHeadData.h"
#import "Activity.h"
#import "XYRefreshHeader.h"
#import "HomeCell.h"
#import "HomeHeaderCell.h"
#import "HomeCategoryCell.h"
#import "WebViewController.h"
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic ,strong) HomeHeadView *headView;
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) NSArray<Goods *> *freshHots;
@property (nonatomic ,strong) HomeHeadData *homeHeadData;
@property (nonatomic ,strong) HomeHeadView *homeHeadView;
@property (nonatomic )        CGFloat homeTableHead;

@end

static NSString *homeCellId = @"homeCellId";
static NSString *homeCatrgoryCellId = @"homeCatrgoryCellId";
static NSString *footerCellId = @"footerCellId";
static NSString *headerCellId = @"headerCellId";

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
    [self buildCollectionView];
    [self buildTableHeadView];
    // Do any additional setup after loading the view.
}
#pragma mark --通知中心
-(void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shopCarBuyNumberDidChange) name:LFBShopCarBuyNumberDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(homeTableHeadViewHeightDidChange:) name:HomeTableHeadViewHeightDidChange object:nil];
}

-(void)shopCarBuyNumberDidChange{
    [self.collectionView reloadData];
}

-(void)homeTableHeadViewHeightDidChange:(NSNotification *)notification{
    CGFloat height = [(NSNumber *)notification.object floatValue];
    self.collectionView.mj_header.ignoredScrollViewContentInsetTop = height;
    self.homeHeadView.frame = CGRectMake(0, -height, XYWidth, height);
    self.collectionView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    self.collectionView.contentOffset = CGPointMake(0, -height);
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark --ColletionView

-(void)buildCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(0, HomeCollectionViewCellMargin, 0, HomeCollectionViewCellMargin);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    [self.collectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:homeCellId];
    [self.collectionView registerClass:[HomeCategoryCell class] forCellWithReuseIdentifier:homeCatrgoryCellId];
    [self.collectionView registerClass:[HomeFooterCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCellId];
    [self.collectionView registerClass:[HomeHeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCellId];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    XYRefreshHeader *header = [XYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerReferesh)];
    header.gifView.frame = CGRectMake(0, 30, 100, 100);
    self.collectionView.mj_header = header;
}

-(void)headerReferesh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView.mj_header endRefreshing];
    });
}
//代理、数据源
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.homeHeadData.category.act_rows.count;
    }else if(section == 1){
        return self.freshHots.count;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        HomeCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCatrgoryCellId forIndexPath:indexPath];
        cell.actRow = self.homeHeadData.category.act_rows[indexPath.row];
        return cell;
    }
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCellId forIndexPath:indexPath];
    cell.goods = self.freshHots[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CGSize itemSize = CGSizeZero;
    if (indexPath.section == 0) {
        itemSize = CGSizeMake(XYWidth, 320);
    }else if(indexPath.section == 1){
        itemSize = CGSizeMake((XYWidth - HomeCollectionViewCellMargin * 2) *0.5- 4, 250);
    }
    return itemSize;
}


-(void)buildTableHeadView{
    __weak typeof(self) weakSelf = self;
    [HomeHeadData loadHeadData:^(id data, NSError *error) {
        weakSelf.homeHeadData = data;
        weakSelf.homeHeadView = [[HomeHeadView alloc]initWithHeadData:data];
        weakSelf.homeHeadView.callback = ^(HeadViewItemType type,NSInteger tag){
            [weakSelf showActityDetail:type tag:tag];
        };
        [weakSelf.collectionView addSubview:weakSelf.homeHeadView];
    }];
    
    [GoodsData loadGoodsData:^(id data, NSError *error) {
        weakSelf.freshHots = data;
        [weakSelf.collectionView reloadData];
    }];
}

-(void)showActityDetail:(HeadViewItemType)type tag:(NSInteger)tag{
    ActInfo *actInfo = self.homeHeadData.act_info[type];
    Activity *activity = actInfo.act_rows[tag].activity;
    [self.navigationController pushViewController:[[WebViewController alloc] initWithActivity:activity] animated:YES];
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
