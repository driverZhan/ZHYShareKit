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
    ZHYShareItem *item1 = [ZHYShareItem initWithImage:@"" title:@"cell1" selectedHandler:^{
        
    }];
    
    ZHYShareItem *item2 = [ZHYShareItem initWithImage:@"" title:@"cell2" selectedHandler:^{
        
    }];
    
    ZHYShareItem *item3 = [ZHYShareItem initWithImage:@"" title:@"cell3" selectedHandler:^{
        
    }];
    
    ZHYShareItem *item4 = [ZHYShareItem initWithImage:@"" title:@"cell4" selectedHandler:^{
        
    }];
    
    ZHYShareItem *item5 = [ZHYShareItem initWithImage:@"" title:@"cell5" selectedHandler:^{
        
    }];
    
    ZHYShareItem *item6 = [ZHYShareItem initWithImage:@"" title:@"cell6" selectedHandler:^{
        
    }];
    
    ZHYShareItem *item7 = [ZHYShareItem initWithImage:@"" title:@"cell7" selectedHandler:^{
        
    }];
    
    ZHYShareItem *item8 = [ZHYShareItem initWithImage:@"" title:@"cell8" selectedHandler:^{
        
    }];
    
    ZHYShareItem *item9 = [ZHYShareItem initWithImage:@"" title:@"cell9" selectedHandler:^{
        
    }];
    
    ZHYShareItem *item10 = [ZHYShareItem initWithImage:@"" title:@"cell10" selectedHandler:^{
        
    }];
    
    [ZHYShareView showViewWithItems:@[item1,item2,item3,item4,item5,item6,item7,item8,item9] pages:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
