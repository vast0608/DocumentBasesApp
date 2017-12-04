//
//  DocumentBrowserViewController.h
//  DocumentBasesApp
//
//  Created by 李晓璐 on 2017/12/1.
//  Copyright © 2017年 onmmc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileType.h"//文件类型

typedef void(^CallBack)(NSData *contentsData, NSArray *fileType, NSString *fileName);

@interface DocumentBrowserViewController : UIDocumentBrowserViewController

@property (nonatomic,copy)CallBack callBack;//回调的block

@end
