//
//  ZHYShareItem.m
//  ZHYShareView-master
//
//  Created by ZHAN on 2017/6/6.
//  Copyright © 2017年 zhan. All rights reserved.
//

#import "ZHYShareItem.h"

@implementation ZHYShareItem
+ (instancetype)initWithImage:(NSString *)image title:(NSString *)title selectedHandler:(void (^)())handler
{
    ZHYShareItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    item.selectedHandler = handler;
    return item;
}
@end
