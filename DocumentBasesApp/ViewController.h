//
//  ViewController.h
//  DocumentBasesApp
//
//  Created by 李晓璐 on 2017/12/1.
//  Copyright © 2017年 onmmc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic, strong)UIImageView *imageV;
@property(nonatomic, strong)UILabel *label;

-(void)contentsData:(NSData *)contentsData fileURL:(NSURL *)fileURL fileName:(NSString *)fileName;

@end

