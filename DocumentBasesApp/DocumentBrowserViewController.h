//
//  DocumentBrowserViewController.h
//  DocumentBasesApp
//
//  Created by 李晓璐 on 2017/12/1.
//  Copyright © 2017年 onmmc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    //---------------------------图片类型-----------------------
    ENUM_Image = 1000,//图片
    //---------------------------音频类型-----------------------
    ENUM_Audio,//音频
    //---------------------------视频类型-----------------------
    ENUM_Video,//视频
    //---------------------------文档类型-----------------------
    ENUM_Txt,//文本
    ENUM_Ppt,//PPT
    ENUM_Word,//Word
    ENUM_Excel,//Excel
    
    ENUM_Rtf,//Rtf
    ENUM_Numbers,//Numbers
    ENUM_Pages,//Pages
    ENUM_KeyNote,//KeyNote
    
    ENUM_Wps,//WPS
    
    ENUM_Html,//Html
    ENUM_MarkDown,//MarkDown
    ENUM_PDF,//PDF
    //---------------------------压缩类型-----------------------
    ENUM_Zip,//Zip
    ENUM_Rar,//Rar
    ENUM_Iso,//Iso
    ENUM_Exe,//Exe
    ENUM_Dmg,//Dmg
    ENUM_Ipa,//Ipa
    ENUM_Apk,//Apk
    //---------------------------其他类型-----------------------
    ENUM_UnKnow,//其他
} FileType;

typedef void(^CallBack)(NSData *contentsData, FileType fileType, NSString *fileName);

@interface DocumentBrowserViewController : UIDocumentBrowserViewController

- (void)presentDocumentAtURL:(NSURL *)documentURL;//在Appdelete里有方法

@property (nonatomic,copy)CallBack callBack;

@end
