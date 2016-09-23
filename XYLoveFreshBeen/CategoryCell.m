//
//  CategoryCell.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/23.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "CategoryCell.h"

@interface CategoryCell ()

@property (nonatomic ,strong) UILabel *nameLable;
@property (nonatomic ,strong) UIImageView *backImageView;
@property (nonatomic ,strong) UIView *yellowView;
@property (nonatomic ,strong) UIView *lineView;

@end

static NSString *cellId = @"cell";

@implementation CategoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _backImageView = [[UIImageView alloc]init];
        _backImageView.image = [UIImage imageNamed:@"llll"];
        _backImageView.highlightedImage = [UIImage imageNamed:@"kkkkkkk"];
       // [self.contentView addSubview:_backImageView];
        [self addSubview:_backImageView];
        _yellowView = [[UIView alloc]init];
        _yellowView.backgroundColor = [UIColor colorWithRed:253/255.0 green:212/255.0 blue:49/255.0 alpha:1.0];
       // [self.contentView addSubview:_yellowView];
        [self addSubview:_yellowView];
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
     //   [self.contentView addSubview:_lineView];
        [self addSubview:_lineView];
        _nameLable = [[UILabel alloc]init];
        _nameLable.backgroundColor = [UIColor clearColor];
        _nameLable.textAlignment = NSTextAlignmentCenter;
        _nameLable.font = [UIFont systemFontOfSize:14];
        _nameLable.textColor = [UIColor grayColor];
        _nameLable.highlightedTextColor = [UIColor blackColor];
      //  [self.contentView addSubview:_nameLable];
        [self addSubview:_nameLable];
        
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [_yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self).offset(-5);
            make.width.mas_equalTo(5);
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

-(void)setCategroies:(ProductCategory *)categroies{
    self.nameLable.text = categroies.name;
}

+(instancetype)cellWithTable:(UITableView *)tableView{
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[CategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.nameLable.highlighted = selected;
    self.yellowView.hidden = !selected;
    self.backImageView.highlighted = selected;
}

@end
