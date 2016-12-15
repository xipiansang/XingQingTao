//
//  LimitViewController.m
//  XingQingTao
//
//  Created by 刘中天 on 2016/12/6.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "LimitViewController.h"

#import "UIImageView+WebCache.h"

#import "SDWebImageManager.h"
@interface LimitViewController (){
    UIImage *iiiii;
}

@end

@implementation LimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor=[UIColor redColor];
    iiiii=[[UIImage alloc] init];
    UIImage *imagevv=[UIImage imageNamed:@"1"];
    
    imagevv=[self reSizeImage:imagevv toSize:CGSizeMake(100, 100)];
    
    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:[NSURL URLWithString:@"http://qr.topscan.com/api.php?text=x"]
                             options:0
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                // progression tracking code
                            }
                           completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                               if (image && finished) {
//                                   image=[self reSizeImage:imagevv toSize:CGSizeMake(50, 50)];
                                   iiiii=image;
                                   NSLog(@"%@", NSStringFromCGSize(iiiii.size));
                               }
                           }];
    image.image=iiiii;
//    UIColor *bgColor=[UIColor colorWithPatternImage:imagevv];
//    [image setBackgroundColor:bgColor];
    [self.view addSubview:image];
    // Do any additional setup after loading the view.
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
