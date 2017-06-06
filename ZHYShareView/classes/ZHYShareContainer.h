//
//  ZHYShareContainer.h
//  ZHYShareView-master
//
//  Created by ZHAN on 2017/6/6.
//  Copyright © 2017年 zhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHYShareItem.h"

@interface ZHYShareContainer : UIToolbar
+ (instancetype)initContainerWithItems:(NSArray *)items pages:(BOOL)showPages;
@end
