//
//  ZFScheduleViewCell.m
//  recurrentDemo
//
//  Created by winstrong on 16/9/20.
//  Copyright © 2016年 winstrong. All rights reserved.
//

#import "ZFScheduleViewCell.h"
#import "Masonry.h"

#define FromRGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@implementation ZFScheduleViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.backView];
        [self.contentView addSubview:self.circleView];
        [self.contentView addSubview:self.redPoint];
        [self.contentView addSubview:self.dayLabel];
    }
    return self;
}

- (UILabel *)dayLabel {
    if(_dayLabel == nil) {
        _dayLabel = [[UILabel alloc] init];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.textColor = FromRGB(50, 50, 50);
        _dayLabel.font = [UIFont systemFontOfSize:18];
    }
    return _dayLabel;
}

- (UIView *)circleView {
    if (_circleView == nil) {
        _circleView = [[UIView alloc] init];
        _circleView.backgroundColor = [UIColor clearColor];
        _circleView.hidden = YES;
    }
    return _circleView;
}

- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = FromRGB(85, 168, 254);
        _backView.hidden = YES;
    }
    return _backView;
}

- (UIView *)redPoint {
    if (_redPoint == nil) {
        _redPoint = [[UIView alloc] init];
        _redPoint.backgroundColor = FromRGB(253, 82, 82);
        _redPoint.hidden = YES;
    }
    return _redPoint;
}

-(void)layoutSubviews
{
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    CGFloat redPointWH = 6;
    CGFloat reduceWH = 13;
    
    CGFloat W = self.frame.size.width - reduceWH;
    CGFloat H = self.frame.size.height- reduceWH;
    
    [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(W, H));
    }];
    _circleView.layer.borderWidth = 1;
    _circleView.layer.borderColor = FromRGB(253, 82, 82).CGColor;
    _circleView.layer.cornerRadius= (self.frame.size.width - reduceWH) / 2;
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(W, H));
    }];
    _backView.layer.cornerRadius= (self.frame.size.width - reduceWH) / 2;
    
    [_redPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dayLabel.mas_bottom).offset(-2.5);
        make.centerX.equalTo(_dayLabel);
        make.size.mas_equalTo(CGSizeMake(redPointWH, redPointWH));
    }];
    _redPoint.layer.cornerRadius= redPointWH/2;
    
}

@end
