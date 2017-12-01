//
//  ViewController.m
//  DocumentBasesApp
//
//  Created by 李晓璐 on 2017/12/1.
//  Copyright © 2017年 onmmc. All rights reserved.
//

#import "ViewController.h"
#import "DocumentBrowserViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


-(void)buttonClick{
    DocumentBrowserViewController *dVC = [DocumentBrowserViewController new];
    
    dVC.callBack = ^(NSData *contentsData, FileType fileType, NSString *fileName) {
        //        NSLog(@"%@----%lu---%@",contentsData,(unsigned long)fileType,fileName);
        
        NSLog(@"----%lu---%@",(unsigned long)fileType,fileName);
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200, 100, 100)];
        imageV.image = [UIImage imageWithData:contentsData];
        [self.view addSubview:imageV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 60)];
        label.text = [NSString stringWithFormat:@"文件类型：%lu\n文件名:%@",(unsigned long)fileType,fileName];
        label.numberOfLines = 2;
        [self.view addSubview:label];
    };
    
    [self presentViewController:dVC animated:YES completion:nil];
}


@end
