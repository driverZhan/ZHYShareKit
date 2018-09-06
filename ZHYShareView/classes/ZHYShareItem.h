//
//  ZHYShareItem.h
//  ZHYShareView-master
//
//  Created by ZHAN on 2017/6/6.
//  Copyright © 2017年 zhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHYShareItem : NSObject
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) void (^selectedHandler)();

+ (instancetype)initWithImage:(NSString *)image
                        title:(NSString *)title
              selectedHandler:(void(^)())handler;
@end
