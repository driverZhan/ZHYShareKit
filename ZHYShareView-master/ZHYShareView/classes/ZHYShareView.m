//
//  ZHYShareView.m
//  ZHYTools
//
//  Created by ZHAN on 2017/6/5.
//  Copyright © 2017年 ZHAN. All rights reserved.
//

#import "ZHYShareView.h"


#define SHAREVIEW_DISMISS_NOTIFICATION @"SHAREVIEW_DISMISS_NOTIFICATION"

#define titleFont [UIFont systemFontOfSize:14]
#define cellInnerMargin 10

#pragma mark ----- Share Item ------
@implementation ZHYShareItem

+ (instancetype)initWithImage:(NSString *)image title:(NSString *)title type:(id)type selectedHandler:(void (^)(id value))handler
{
    ZHYShareItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    item.type = type;
    item.selectedHandler = handler;
    return item;
}

@end

#pragma mark ----- Share Container --------
@interface ZHYShareContainer()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZHYCollectionViewHorizontalLayout *layout;
@property (nonatomic, strong) NSArray *cellItems;
@end

@implementation ZHYShareContainer

+ (instancetype)initContainerWithItems:(NSArray *)items {
    ZHYShareContainer *container = [[ZHYShareContainer alloc] initWithFrame:CGRectMake(0,
                                                                                       MAIN_SCREEN_HEIGHT,
                                                                                       MAIN_SCREEN_WIDTH,
                                                                                       containerHeight)];
    NSMutableArray *array = [NSMutableArray arrayWithArray:items];
    if (items.count % pageSize != 0) {
        for (int j = 0; j < (pageSize - items.count % pageSize); j++) {
            ZHYShareItem *item = [ZHYShareItem new];
            [array addObject:item];
        }
    }
    container.cellItems = array;
    return container;
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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 10, MAIN_SCREEN_WIDTH - 20, containerHeight - 10 - 10 - cancelButtonHeight) collectionViewLayout:self.layout];
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

#pragma mark -- 取消 ---
- (void)cancel
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHAREVIEW_DISMISS_NOTIFICATION object:nil];
}

@end

#pragma mark ----- ZHYCollectionViewHorizontalLayout ---

@interface ZHYCollectionViewHorizontalLayout()<UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *allAttributes;
@end

@implementation ZHYCollectionViewHorizontalLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    NSInteger sections = [self.collectionView numberOfSections];
    
    for (int i = 0; i < sections; i ++) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:0];
        NSUInteger count = [self.collectionView numberOfItemsInSection:i];
        for (NSUInteger j = 0; j < count; j ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [tempArray addObject:attributes];
        }
        [self.allAttributes addObject:tempArray];
    }
}

- (CGSize)collectionViewContentSize
{
    return [super collectionViewContentSize];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger item = indexPath.item;
    NSUInteger x;
    NSUInteger y;
    [self targetPositionWithItem:item resultX:&x resultY:&y];
    NSUInteger item2 = [self originItemAtX:x y:y];
    NSIndexPath *theNewIndexPath = [NSIndexPath indexPathForItem:item2 inSection:indexPath.section];
    
    UICollectionViewLayoutAttributes *theNewAttr = [super layoutAttributesForItemAtIndexPath:theNewIndexPath];
    theNewAttr.indexPath = indexPath;
    return theNewAttr;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *tmp = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        for (NSMutableArray *attributes in self.allAttributes)
        {
            for (UICollectionViewLayoutAttributes *attr2 in attributes) {
                if (attr.indexPath.item == attr2.indexPath.item) {
                    [tmp addObject:attr2];
                    break;
                }
            }
            
        }
    }
    return tmp;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

// 根据 item 计算目标item的位置
// x 横向偏移  y 竖向偏移
- (void)targetPositionWithItem:(NSUInteger)item resultX:(NSUInteger *)x resultY:(NSUInteger *)y
{
    NSUInteger page = item/(self.itemCountPerRow*self._rowCount);
    
    NSUInteger theX = item % self.itemCountPerRow + page * self.itemCountPerRow;
    NSUInteger theY = item / self.itemCountPerRow - page * self._rowCount;
    if (x != NULL) {
        *x = theX;
    }
    if (y != NULL) {
        *y = theY;
    }
}

// 根据偏移量计算item
- (NSUInteger)originItemAtX:(NSUInteger)x
                          y:(NSUInteger)y
{
    NSUInteger item = x * self._rowCount + y;
    return item;
}


- (NSMutableArray *)allAttributes
{
    if (!_allAttributes) {
        _allAttributes = [NSMutableArray array];
    }
    return _allAttributes;
}

@end

#pragma mark ----- Share Item Cell --------

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

#pragma mark ----- Share View --------

@interface ZHYShareView()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) ZHYShareContainer *container;
@property (nonatomic, strong) UIView *markLayer;
@end
@implementation ZHYShareView

- (instancetype)initWithItems:(NSArray *)items{
    if ([super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)]) {
        self.items = items;
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
        _container = [ZHYShareContainer initContainerWithItems:self.items];
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
+ (void)showViewWithItems:(NSArray *)items{
    ZHYShareView *shareView = [[self alloc] initWithItems:items];
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
    [shareView showAnimation];
}

- (void)dealloc
{
    NSLog(@"释放内存");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
