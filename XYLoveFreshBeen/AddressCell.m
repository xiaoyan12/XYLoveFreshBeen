//
//  AddressCell.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "AddressCell.h"

@interface AddressCell ()

@property (nonatomic ,strong) UILabel *nameLable;
@property (nonatomic ,strong) UILabel *phoneLable;
@property (nonatomic ,strong) UILabel *addressLable;
@property (nonatomic ,strong) UIImageView *modifImageView;
@property (nonatomic ,copy)   ModifyCallback callback;

@end

@implementation AddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _nameLable = [[UILabel alloc]init];
        _nameLable.font = [UIFont systemFontOfSize:14];
        _nameLable.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
        [self addSubview:_nameLable];
        
        _phoneLable = [[UILabel alloc]init];
        _phoneLable.font = [UIFont systemFontOfSize:14];
        _phoneLable.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
        [self addSubview:_phoneLable];
        
        _addressLable = [[UILabel alloc]init];
        _addressLable.font = [UIFont systemFontOfSize:13];
        _addressLable.textColor = [UIColor lightGrayColor];
        [self addSubview:_addressLable];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        [self addSubview:lineView];
        
        _modifImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v2_address_edit_highlighted"]];
        _modifImageView.contentMode = UIViewContentModeCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(modifyImageViewClick:)];
        _modifImageView.userInteractionEnabled = YES;
        [_modifImageView addGestureRecognizer:tap];
        [self addSubview:_modifImageView];
        
        UIView *bottonView = [[UIView alloc]init];
        bottonView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        [self addSubview:bottonView];
        
        [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(20);
            make.width.mas_equalTo(100);
            make.top.equalTo(self).offset(10);
            make.height.mas_equalTo(30);
        }];
        
        [_phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_nameLable.mas_trailing);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
            make.top.equalTo(_nameLable.mas_top);
        }];
        
        [_addressLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_nameLable.mas_leading);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(30);
            make.bottom.equalTo(self).offset(-10);
        }];
        
        [_modifImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.trailing.equalTo(self).offset(-20);
        }];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(1);
            make.top.equalTo(self).offset(10);
            make.bottom.equalTo(self).offset(-10);
            make.trailing.equalTo(_modifImageView.mas_leading).offset(-10);
        }];
        
        [bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.leading.trailing.bottom.equalTo(self);
        }];
        
    }
    return self;
}

-(void)modifyImageViewClick:(UITapGestureRecognizer *)tap{
    if (_callback) {
        _callback(tap.view.tag);
    }
}

-(void)setAddress:(Address *)address{
    _address = address;
    self.nameLable.text = address.accept_name;
    self.phoneLable.text = address.telphone;
    self.addressLable.text = address.address;
}

+(instancetype)cellWithTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath callbackBlock:(ModifyCallback)callback{
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.modifImageView.tag = indexPath.row;
    cell.callback = callback;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
