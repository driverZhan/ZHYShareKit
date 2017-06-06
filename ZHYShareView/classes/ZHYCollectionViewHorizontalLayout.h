//
//  ZHYCollectionViewHorizontalLayout.h
//  ZHYShareView-master
//
//  Created by ZHAN on 2017/6/6.
//  Copyright © 2017年 zhan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZHYCollectionViewHorizontalLayout : UICollectionViewFlowLayout
//  一行中 cell 的个数
@property (nonatomic,assign) NSUInteger itemCountPerRow;

//    一页显示多少行
@property (nonatomic,assign) NSUInteger _rowCount;
@end

