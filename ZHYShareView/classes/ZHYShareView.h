//
//  ZHYShareView.h
//  ZHYTools
//
//  Created by ZHAN on 2017/6/5.
//  Copyright © 2017年 ZHAN. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAIN_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define MAIN_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define cancelButtonHeight 40
#define containerHeight 230 * MAIN_SCREEN_HEIGHT / 667
#define rowCount 2
#define itemCountAtRow 4
#define pageSize 8

@interface ZHYShareItem : NSObject
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) id type;
@property (nonatomic, strong) void (^selectedHandler)(id value);

+ (instancetype)initWithImage:(NSString *)image
                        title:(NSString *)title
                         type:(id)type
              selectedHandler:(void(^)(id value))handler;
@end

@interface ZHYShareContainer : UIToolbar

+ (instancetype)initContainerWithItems:(NSArray *)items;

@end

@interface ZHYCollectionViewHorizontalLayout : UICollectionViewFlowLayout
//  一行中 cell 的个数
@property (nonatomic,assign) NSUInteger itemCountPerRow;

//    一页显示多少行
@property (nonatomic,assign) NSUInteger _rowCount;
@end

@interface ZHYShareItemCell : UICollectionViewCell
- (void)setItem:(ZHYShareItem *)item;
@end



@interface ZHYShareView : UIView
@property (nonatomic, strong) NSArray *items;

+ (void)showViewWithItems:(NSArray *)items;
@end
