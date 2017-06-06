//
//  ZHYShareView.m
//  ZHYTools
//
//  Created by ZHAN on 2017/6/5.
//  Copyright © 2017年 ZHAN. All rights reserved.
//

#import "ZHYShareView.h"
#import "ZHYHeader.h"

@interface ZHYShareView()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) ZHYShareContainer *container;
@property (nonatomic, strong) UIView *markLayer;
@property (nonatomic, assign) BOOL showfullPage;
@end
@implementation ZHYShareView

- (instancetype)initWithItems:(NSArray *)items pages:(BOOL)showPages
{
    if ([super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)]) {
        self.items = items;
        self.showfullPage = showPages;
        [self initUserInterface];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:SHAREVIEW_DISMISS_NOTIFICATION object:nil];
    }
    return self;
}

- (void)initUserInterface
{
    [self addSubview:self.markLayer];
    [self addSubview:self.container];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.container.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        self.container.transform = CGAffineTransformMakeTranslation(0, -containerHeight);
    }];
}

#pragma mark --- getter  ---h
- (UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    }
    return _tapGesture;
}

- (ZHYShareContainer *)container
{
    if (!_container) {
        _container = [ZHYShareContainer initContainerWithItems:self.items pages:self.showfullPage];
    }
    return _container;
}

- (UIView *)markLayer
{
    if (!_markLayer) {
        _markLayer = [[UIView alloc] init];
        _markLayer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        _markLayer.frame = self.bounds;
        [_markLayer addGestureRecognizer:self.tapGesture];
    }
    return _markLayer;
}

#pragma mark --- 快速显示
+ (void)showViewWithItems:(NSArray *)items pages:(BOOL)showPages{
    ZHYShareView *shareView = [[self alloc] initWithItems:items pages:showPages];
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
    [shareView showAnimation];
}

- (void)dealloc
{
    NSLog(@"释放内存");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
