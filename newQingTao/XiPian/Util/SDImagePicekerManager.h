//
//  SDImagePicekerManager.h
//  Test
//
//  Created by yu on 16/2/24.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TZImagePickerController.h"

typedef void(^DidFinishPickingPhotosHandle)(NSArray *imageArray);

@interface SDImagePicekerManager : NSObject

@property (nonatomic, copy) DidFinishPickingPhotosHandle  block;

/**
 *  选择图片
 *
 *  @param vc             展示控制器
 *  @param maxImagesCount 选择图片的最大数量
 *  @param block          选择图片完成的回调block
 */
+ (void)chooseImageWithShowPickerVC:(UIViewController *)vc
                     maxImagesCount:(NSInteger)maxImagesCount
                       allowEditing:(BOOL)allowEditing
                      complateBlock:(DidFinishPickingPhotosHandle)block;



@end

