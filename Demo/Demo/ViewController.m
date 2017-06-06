//
//  ViewController.m
//  Demo
//
//  Created by ZHAN on 2017/6/6.
//  Copyright © 2017年 ZHAN. All rights reserved.
//

#import "ViewController.h"
#import "ZHYShareView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)show:(id)sender
{
    ZHYShareItem *item1 = [ZHYShareItem initWithImage:@"" title:@"cell1" type:@1 selectedHandler:^(id value){
        NSLog(@"item4%@",value);
    }];
    
    ZHYShareItem *item2 = [ZHYShareItem initWithImage:@"" title:@"cell2" type:@2 selectedHandler:^(id value){
        NSLog(@"item4%@",value);
    }];
    
    ZHYShareItem *item3 = [ZHYShareItem initWithImage:@"" title:@"cell3" type:@3 selectedHandler:^(id value){
        NSLog(@"item4%@",value);
    }];
    
    ZHYShareItem *item4 = [ZHYShareItem initWithImage:@"" title:@"cell4" type:@4 selectedHandler:^(id value){
        NSLog(@"item4%@",value);
    }];
    
    ZHYShareItem *item5 = [ZHYShareItem initWithImage:@"" title:@"cell5" type:@5 selectedHandler:^(id value){
        NSLog(@"item4%@",value);
    }];
    
    ZHYShareItem *item6 = [ZHYShareItem initWithImage:@"" title:@"cell6" type:@6 selectedHandler:^(id value){
        NSLog(@"item4%@",value);
    }];
    
    ZHYShareItem *item7 = [ZHYShareItem initWithImage:@"" title:@"cell7" type:@7 selectedHandler:^(id value){
        NSLog(@"item4%@",value);
    }];
    
    ZHYShareItem *item8 = [ZHYShareItem initWithImage:@"" title:@"cell8" type:@8 selectedHandler:^(id value){
        NSLog(@"item4%@",value);
    }];
    
    ZHYShareItem *item9 = [ZHYShareItem initWithImage:@"" title:@"cell9" type:@9 selectedHandler:^(id value){
        NSLog(@"item4%@",value);
    }];
    
    ZHYShareItem *item10 = [ZHYShareItem initWithImage:@"" title:@"cell10" type:@10 selectedHandler:^(id value){
        NSLog(@"item4%@",value);
    }];
    
    [ZHYShareView showViewWithItems:@[item1,item2,item3,item4,item5,item6,item7,item8,item9] pages:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
