//
//  erweima.h
//  erweima
//
//  Created by 刘中天 on 2016/12/13.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface erweima : NSObject

//根据十六进制的字符串处理成为保存倍数的数组
+(NSMutableArray *)getArrayForColor:(NSString *)colorS;

//生成二维码（最屌）
+ (UIImage *)qrCodeImageWithContent:(NSString *)content
                      codeImageSize:(CGFloat)size
                               logo:(UIImage *)logo
                          logoFrame:(CGRect)logoFrame
                                red:(CGFloat)red
                              green:(CGFloat)green
                               blue:(CGFloat)blue;
//改变二维码颜色
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

//改变二维码尺寸大小
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size;

//生成最原始的二维码
+ (CIImage *)qrCodeImageWithContent:(NSString *)content;
@end
