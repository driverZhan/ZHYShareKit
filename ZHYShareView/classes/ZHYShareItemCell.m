//
//  ZHYShareItemCell.m
//  ZHYShareView-master
//
//  Created by ZHAN on 2017/6/6.
//  Copyright © 2017年 zhan. All rights reserved.
//

#import "ZHYShareItemCell.h"
#import "ZHYShareItem.h"
#import "ZHYHeader.h"

#define titleFont [UIFont systemFontOfSize:14]
#define cellInnerMargin 10

@interface ZHYShareItemCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *imageView;
@property (nonatomic, strong) ZHYShareItem *sItem;
@property (nonatomic, strong) void(^handler)(id value);
@end

@implementation ZHYShareItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.tag = 1314;
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setItem:(ZHYShareItem *)item
{
    if (item == nil) {
        return;
    }
    self.sItem = item;
    [self.imageView setImage:[UIImage imageNamed:item.image] forState:UIControlStateNormal];
    self.titleLabel.text = item.title;
    self.handler = item.selectedHandler;
}

- (UIButton *)imageView
{
    if (!_imageView) {
        CGFloat cellWidth = CGRectGetWidth(self.frame);
        CGFloat cellHeight = CGRectGetHeight(self.frame);
        CGFloat width = MIN(CGRectGetWidth(self.frame) - titleFont.lineHeight - cellInnerMargin, CGRectGetHeight(self.frame) - titleFont.lineHeight - cellInnerMargin);
        CGRect frame = CGRectMake((cellWidth - width) / 2,
                                  (cellHeight - width - CGRectGetHeight(self.titleLabel.frame)) / 2,
                                  width,
                                  width);
        _imageView = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageView.frame = frame;
        [_imageView addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(0,
                                       CGRectGetHeight(self.frame) - titleFont.lineHeight,
                                       CGRectGetWidth(self.frame),
                                       titleFont.lineHeight);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"测试";
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.font = titleFont;
    }
    return _titleLabel;
}

- (void)buttonClicked:(UIButton *)sender
{
    if (self.handler) {
        self.handler(self.sItem.type);
        [[NSNotificationCenter defaultCenter] postNotificationName:SHAREVIEW_DISMISS_NOTIFICATION object:nil];
    }
}

@end
