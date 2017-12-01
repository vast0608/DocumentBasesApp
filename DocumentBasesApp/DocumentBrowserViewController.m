//
//  DocumentBrowserViewController.m
//  DocumentBasesApp
//
//  Created by 李晓璐 on 2017/12/1.
//  Copyright © 2017年 onmmc. All rights reserved.
//

#import "DocumentBrowserViewController.h"

#pragma mark---------------------------------Document------------------------------------
@interface Document : UIDocument

@property(nonatomic, strong)NSData *contentsData;

@end

@implementation Document

- (id)contentsForType:(NSString*)typeName error:(NSError **)errorPtr {
    // Encode your document with an instance of NSData or NSFileWrapper
    
    return [[NSData alloc] init];
}

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError **)errorPtr {
    // Load your document from contents
    
    NSLog(@"%@---%@--",contents,typeName);
    
    NSData *data = [NSData dataWithData:contents];
    
    _contentsData = data;
    
    return YES;
}

@end

#pragma mark-------------------------DocumentBrowserViewController-----------------------------

@interface DocumentBrowserViewController () <UIDocumentBrowserViewControllerDelegate>

@end

@implementation DocumentBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.allowsDocumentCreation = NO;
    self.allowsPickingMultipleItems = NO;
    
    // Update the style of the UIDocumentBrowserViewController
    self.browserUserInterfaceStyle = UIDocumentBrowserUserInterfaceStyleLight;
    self.view.tintColor = [UIColor redColor];
    
    
    // Specify the allowed content types of your application via the Info.plist.
    
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.additionalLeadingNavigationBarButtonItems = @[buttonItem];
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark UIDocumentBrowserViewControllerDelegate

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller didRequestDocumentCreationWithHandler:(void (^)(NSURL * _Nullable, UIDocumentBrowserImportMode))importHandler {
    NSURL *newDocumentURL = nil;
    
    // Set the URL for the new document here. Optionally, you can present a template chooser before calling the importHandler.
    // Make sure the importHandler is always called, even if the user cancels the creation request.
    if (newDocumentURL != nil) {
        importHandler(newDocumentURL, UIDocumentBrowserImportModeMove);
    } else {
        importHandler(newDocumentURL, UIDocumentBrowserImportModeNone);
        //[self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)documentBrowser:(UIDocumentBrowserViewController *)controller didPickDocumentURLs:(NSArray<NSURL *> *)documentURLs {
    NSURL *sourceURL = documentURLs.firstObject;
    if (!sourceURL) {
        return;
    }
    
    // Present the Document View Controller for the first document that was picked.
    // If you support picking multiple items, make sure you handle them all.
    [self presentDocumentAtURL:sourceURL];
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller didImportDocumentAtURL:(NSURL *)sourceURL toDestinationURL:(NSURL *)destinationURL {
    // Present the Document View Controller for the new newly created document
    [self presentDocumentAtURL:destinationURL];
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller failedToImportDocumentAtURL:(NSURL *)documentURL error:(NSError * _Nullable)error {
    // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
}

// MARK: Document Presentation

- (void)presentDocumentAtURL:(NSURL *)documentURL {
    Document *docu = [[Document alloc]initWithFileURL:documentURL];
    //开启
    [docu openWithCompletionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"--%@---",docu.fileURL);
            NSLog(@"--%@---",docu.localizedName);
            NSLog(@"--%@---",docu.fileType);
            NSLog(@"--%@---",docu.fileModificationDate);
            NSLog(@"--%lu---",(unsigned long)docu.documentState);
            NSLog(@"--%@---",docu.progress);
            
            //关闭
            [docu closeWithCompletionHandler:^(BOOL success) {
                
                self.callBack(docu.contentsData, [self fieldType:docu.fileURL], docu.localizedName);
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

//判断文件格式
-(FileType)fieldType:(NSURL *)fieldType{
    if (fieldType==nil) {
        return ENUM_UnKnow;
    }
    NSArray *array = [[NSString stringWithFormat:@"%@",fieldType] componentsSeparatedByString:@"."]; //字符串按照【分隔成数组
    NSString *contentStr = array.lastObject;
    //---------------------------图片类型-----------------------
    if ([contentStr containsString:@"png"]||[contentStr containsString:@"jpg"]||[contentStr containsString:@"jpeg"]||[contentStr containsString:@"gif"]||[contentStr containsString:@"bmp"]||[contentStr containsString:@"pic"]||[contentStr containsString:@"tif"]) {//图片
        return ENUM_Image;
    }
    //---------------------------音频类型-----------------------
    if ([contentStr containsString:@"mp3"]||[contentStr containsString:@"wav"]||[contentStr containsString:@"ram"]||[contentStr containsString:@"aif"]||[contentStr containsString:@"au"]||[contentStr containsString:@"wma"]||[contentStr containsString:@"mmf"]||[contentStr containsString:@"amr"]||[contentStr containsString:@"aac"]||[contentStr containsString:@"flac"]) {//音频
        return ENUM_Audio;
    }
    //---------------------------视频类型-----------------------
    if ([contentStr containsString:@"mp4"]||[contentStr containsString:@"avi"]||[contentStr containsString:@"mov"]||[contentStr containsString:@"rmvb"]||[contentStr containsString:@"rm"]||[contentStr containsString:@"mpg"]||[contentStr containsString:@"swf"]) {//视频
        return ENUM_Video;
    }
    //---------------------------文档类型-----------------------
    //-----Windows----
    if ([contentStr containsString:@"ppt"]) {//windows_PPT
        return ENUM_Ppt;
    }
    if ([contentStr containsString:@"doc"]) {//windows_Word
        return ENUM_Word;
    }
    if ([contentStr containsString:@"xls"]) {//windows_Excel
        return ENUM_Excel;
    }
    if ([contentStr containsString:@"txt"]) {//windows_TXT
        return ENUM_Txt;
    }
    //------Mac------
    if ([contentStr containsString:@"rtf"]) {//Mac_Rtf
        return ENUM_Rtf;
    }
    if ([contentStr containsString:@"numbers"]) {//Mac_Numbers
        return ENUM_Numbers;
    }
    if ([contentStr containsString:@"pages"]) {//Mac_Pages
        return ENUM_Pages;
    }
    if ([contentStr containsString:@"key"]) {//Mac_KeyNote
        return ENUM_KeyNote;
    }
    //------WPS------
    if ([contentStr containsString:@"wps"]) {//windows_TXT
        return ENUM_Wps;
    }
    //------其他-----
    if ([contentStr containsString:@"html"]) {//Web_Html
        return ENUM_Html;
    }
    if ([contentStr containsString:@"md"]) {//MarkDown_Md
        return ENUM_MarkDown;
    }
    if ([contentStr containsString:@"pdf"]) {//PDF
        return ENUM_PDF;
    }
    //---------------------------压缩类型-----------------------
    if ([contentStr containsString:@"zip"]) {//Zip
        return ENUM_Zip;
    }
    if ([contentStr containsString:@"rar"]) {//Rar
        return ENUM_Rar;
    }
    if ([contentStr containsString:@"iso"]) {//Iso
        return ENUM_Iso;
    }
    if ([contentStr containsString:@"exe"]) {//Exe
        return ENUM_Exe;
    }
    if ([contentStr containsString:@"dmg"]) {//Dmg
        return ENUM_Dmg;
    }
    if ([contentStr containsString:@"ipa"]) {//Ipa
        return ENUM_Ipa;
    }
    if ([contentStr containsString:@"apk"]) {//Apk
        return ENUM_Apk;
    }
    //---------------------------其他类型-----------------------
    return ENUM_UnKnow;
}


@end
