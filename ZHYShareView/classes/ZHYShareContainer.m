//
//  ZHYShareContainer.m
//  ZHYShareView-master
//
//  Created by ZHAN on 2017/6/6.
//  Copyright © 2017年 zhan. All rights reserved.
//

#import "ZHYShareContainer.h"
#import "ZHYCollectionViewHorizontalLayout.h"
#import "ZHYShareItemCell.h"
#import "ZHYHeader.h"

@interface ZHYShareContainer()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZHYCollectionViewHorizontalLayout *layout;
@property (nonatomic, strong) NSArray *cellItems;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation ZHYShareContainer

+ (instancetype)initContainerWithItems:(NSArray *)items pages:(BOOL)showPages
{
    ZHYShareContainer *container = [[ZHYShareContainer alloc] initWithFrame:CGRectMake(0,
                                                                                       MAIN_SCREEN_HEIGHT,
                                                                                       MAIN_SCREEN_WIDTH,
                                                                                       containerHeight)];
    NSMutableArray *array = [NSMutableArray arrayWithArray:items];
    if (showPages) {
        if (items.count % pageSize != 0) {
            for (int j = 0; j < (pageSize - items.count % pageSize); j++) {
                ZHYShareItem *item = [ZHYShareItem new];
                [array addObject:item];
            }
        }
    }
    
    container.cellItems = array;
    [container configPageControl];
    return container;
}

- (void)configPageControl
{
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = self.cellItems.count / pageSize;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self initUserInterFace];
    }
    return self;
}

- (void)initUserInterFace {
    self.backgroundColor = [UIColor colorWithRed:220 / 255.0f
                                           green:220 / 255.0f
                                            blue:220 / 255.0f
                                           alpha:1];
    
    [self addSubview:self.collectionView];
    [self addSubview:self.cancelButton];
    [self addSubview:self.pageControl];
    
}

- (void)setCellItems:(NSArray *)cellItems
{
    _cellItems = cellItems;
    [self addSubview:self.pageControl];
}


#pragma mark -- collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cellItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZHYShareItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    ZHYShareItem *item = self.cellItems[indexPath.row];
    NSAssert([item isKindOfClass:[ZHYShareItem class]], @"item type must be ZHYShareItem");
    [cell setItem:item];
    return cell;
}

-  (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZHYShareItem *item = self.cellItems[indexPath.row];
    if (item.selectedHandler) {
        item.selectedHandler(nil);
        [[NSNotificationCenter defaultCenter] postNotificationName:SHAREVIEW_DISMISS_NOTIFICATION object:nil];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_pageControl) {
        CGFloat offsetX = scrollView.contentOffset.x;
        CGFloat screenWidth = CGRectGetWidth(self.collectionView.frame);
        NSUInteger page = offsetX / screenWidth;
        self.pageControl.currentPage = page;
    }
}

#pragma mark --- setter ---
- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _cancelButton.frame = CGRectMake(0, CGRectGetHeight(self.frame) - cancelButtonHeight, MAIN_SCREEN_WIDTH, cancelButtonHeight);
        _cancelButton.backgroundColor = [UIColor whiteColor];
        _cancelButton.layer.shadowOffset = CGSizeMake(0, 1);
        _cancelButton.layer.shadowOpacity = 1.0f;
        _cancelButton.layer.shadowColor = [UIColor colorWithRed:210 / 255.f green:210 / 255.f blue:210 / 255.f alpha:1].CGColor;
        [_cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, MAIN_SCREEN_WIDTH - 20, containerHeight - 10 - 10 - cancelButtonHeight) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.clipsToBounds = YES;
        _collectionView.pagingEnabled = YES;
        _collectionView.tag = 1315;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[ZHYShareItemCell class] forCellWithReuseIdentifier:@"Cell"];
    }
    return _collectionView;
}

- (ZHYCollectionViewHorizontalLayout *)layout
{
    if (!_layout) {
        _layout = [[ZHYCollectionViewHorizontalLayout alloc] init];
        _layout.itemSize = CGSizeMake((MAIN_SCREEN_WIDTH - (itemCountAtRow - 1) - 20) / itemCountAtRow, (containerHeight - 10 - 10 - cancelButtonHeight - 1) / rowCount);
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 1;
        _layout.minimumInteritemSpacing = 1;
        _layout._rowCount = rowCount;
        _layout.itemCountPerRow = itemCountAtRow;
    }
    return _layout;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        [self.pageControl sizeToFit];
        self.pageControl.frame = CGRectMake(0, containerHeight - cancelButtonHeight - 20, MAIN_SCREEN_WIDTH, 20);
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:180 / 255.0f green:180 / 255.0f blue:180 / 255.0f alpha:1];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:210 / 255.0f green:210 / 255.0f blue:210 / 255.0f alpha:1];
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}

#pragma mark -- 取消 ---
- (void)cancel
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHAREVIEW_DISMISS_NOTIFICATION object:nil];
}

@end
