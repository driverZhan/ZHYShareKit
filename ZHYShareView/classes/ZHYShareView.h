//
//  ZHYShareView.h
//  ZHYTools
//
//  Created by ZHAN on 2017/6/5.
//  Copyright © 2017年 ZHAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHYShareContainer.h"

@interface ZHYShareView : UIView
@property (nonatomic, strong) NSArray *items;
+ (void)showViewWithItems:(NSArray *)items pages:(BOOL)showPages;
@end
