//
//  erweima.m
//  erweima
//
//  Created by 刘中天 on 2016/12/13.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "erweima.h"

@implementation erweima



#pragma mark - 生成二维码
+ (UIImage *)qrCodeImageWithContent:(NSString *)content
                      codeImageSize:(CGFloat)size
                               logo:(UIImage *)logo
                          logoFrame:(CGRect)logoFrame
                                red:(CGFloat)red
                              green:(CGFloat)green
                               blue:(CGFloat)blue{
    
    UIImage *image = [self qrCodeImageWithContent:content codeImageSize:size red:red green:green blue:blue];
    //有 logo 则绘制 logo
    if (logo != nil) {
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        [logo drawInRect:logoFrame];
        UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resultImage;
    }else{
        return image;
    }
    
}

//改变二维码颜色
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    UIImage *image = [self qrCodeImageWithContent:content codeImageSize:size];
    int imageWidth = image.size.width;
    int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef, kCGBitmapByteOrder32Little|kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    //遍历像素, 改变像素点颜色
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i<pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red*255;
            ptr[2] = green*255;
            ptr[1] = blue*255;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    //取出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpaceRef,kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpaceRef);
    
    return resultImage;
}

+(NSMutableArray *)getArrayForColor:(NSString *)colorS{
    NSMutableArray *colorArray=[NSMutableArray array];
    for (int i=0; i<3; i++) {
        float   red =(float) strtoul([[colorS substringWithRange:NSMakeRange(0+i*2, 2)] UTF8String],0,16);
        float redd=red/255;
        NSString *string=[NSString stringWithFormat:@"%0.2f",redd];
        float reddd=[string floatValue];
        //存入
        NSNumber *number = [NSNumber numberWithFloat:reddd];
        [colorArray addObject:number];
    }
    return colorArray;
}

//改变二维码尺寸大小
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size{
    CIImage *image = [self qrCodeImageWithContent:content];
    CGRect integralRect = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(integralRect), size/CGRectGetHeight(integralRect));
    
    size_t width = CGRectGetWidth(integralRect)*scale;
    size_t height = CGRectGetHeight(integralRect)*scale;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:integralRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, integralRect, bitmapImage);
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

//生成最原始的二维码
+ (CIImage *)qrCodeImageWithContent:(NSString *)content{
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    [qrFilter setValue:contentData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    CIImage *image = qrFilter.outputImage;
    return image;
}

void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}

@end
