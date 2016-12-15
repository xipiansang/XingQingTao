//
//  SDImagePicekerManager.m
//  Test
//
//  Created by yu on 16/2/24.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "SDImagePicekerManager.h"
#import "MMSheetView.h"

@interface SDImagePicekerManager ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, assign) NSInteger     maxCount;
@property (nonatomic, strong) UIViewController     *showPickerVC;
/**
 *  是否支持编辑，只在maxCount == 1时有效
 */
@property (nonatomic, assign, getter=isAllowEditing) BOOL allowEditing;


@end

@implementation SDImagePicekerManager

+ (SDImagePicekerManager *)shareManager
{
    static SDImagePicekerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SDImagePicekerManager alloc] init];
    });
    return manager;
}

+ (void)chooseImageWithShowPickerVC:(UIViewController *)vc
                     maxImagesCount:(NSInteger)maxImagesCount
                       allowEditing:(BOOL)allowEditing
              complateBlock:(DidFinishPickingPhotosHandle)block
{
    
    [self shareManager].showPickerVC = vc;
    [self shareManager].block = block;
    [self shareManager].maxCount = maxImagesCount <= 0 ? 1 : maxImagesCount;
    [self shareManager].allowEditing = allowEditing;

    WS(weakSelf);
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    MMPopupItemHandler handler = ^(NSInteger index){
        if (index == 0) {
            [[weakSelf shareManager] chooseImageFromCamera];
        }else {
            if ([weakSelf shareManager].maxCount == 1) {
                [[weakSelf shareManager] chooseSingleImageFromPhotoAlbum];
            } else {
                [[weakSelf shareManager] chooseImageFromPhotoalbum];
            }
        }
    };
    
    NSArray *items =
    @[MMItemMake(@"拍照", MMItemTypeNormal, handler),
      MMItemMake(@"从相册选择", MMItemTypeNormal, handler)];
    
    [[[MMSheetView alloc] initWithTitle:@""
                                  items:items] showWithBlock:nil];
    
}

- (void)chooseSingleImageFromPhotoAlbum
{
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerImage.sourceType = sourceType;
    pickerImage.delegate = self;
    if (self.maxCount == 1) {
        pickerImage.allowsEditing = self.isAllowEditing;
    }
    [self.showPickerVC presentViewController:pickerImage animated:YES completion:nil];
}

- (void)chooseImageFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //拍照
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerImage.sourceType = sourceType;
        pickerImage.delegate = self;
        if (self.maxCount == 1) {
            pickerImage.allowsEditing = self.isAllowEditing;
        }
        [self.showPickerVC presentViewController:pickerImage animated:YES completion:nil];
    }else {
        [SDHUDManager showErrorWithStatus:@"相机不可用" bgViewController:nil];
//        NSLog(@"相机不可用");
    }
}

- (void)chooseImageFromPhotoalbum
{
    TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCount delegate:nil];
    picker.allowPickingVideo = NO;
    __weak typeof(self)weakSelf = self;
    [picker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
        if (weakSelf.block) {
            weakSelf.block(photos);
        }
    }];
    [self.showPickerVC presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    image = [self imageCompressWithImage:image];
    NSArray *array = @[image];
    if (self.block) {
        self.block(array);
    }
}

- (UIImage *)imageCompressWithImage:(UIImage*)image
{
    CGFloat value = MAX(image.size.height, image.size.width);
    if (value < 1000.0) {
        return image;
    }
    CGFloat scaledValue = 1000.0 / value;
    
    CGSize newSize = CGSizeMake(image.size.width * scaledValue, image.size.height * scaledValue);
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}




@end
