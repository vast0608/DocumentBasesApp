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
    [button setTitle:@"点击" forState:0];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200, 100, 100)];
    _imageV.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_imageV];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 60)];
    _label.numberOfLines = 2;
    _label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_label];
}


-(void)buttonClick{
    DocumentBrowserViewController *dVC = [DocumentBrowserViewController new];
    
    dVC.callBack = ^(NSData *contentsData, NSArray *fileType, NSString *fileName) {

        NSLog(@"--%@--#--%@-#--%@",contentsData,fileType,fileName);
        //测试代码，随便写的
        _imageV.image = [UIImage imageWithData:contentsData];
        _label.text = [NSString stringWithFormat:@"文件类型：%@\n文件名:%@",fileType[1],fileName];
    };
    
    [self presentViewController:dVC animated:YES completion:nil];
}
-(void)contentsData:(NSData *)contentsData fileURL:(NSURL *)fileURL fileName:(NSString *)fileName{

    NSLog(@"---%@-**--%@--**-%@",contentsData,[FileType fieldType:fileURL],fileName);
    
    _imageV.image = [UIImage imageWithData:contentsData];
    _label.text = [NSString stringWithFormat:@"文件类型：%@\n文件名:%@",[FileType fieldType:fileURL][1],fileName];
    
}

@end
