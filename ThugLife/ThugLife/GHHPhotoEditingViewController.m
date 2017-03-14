//
//  GHHPhotoEditingViewController.m
//  ThugLife
//
//  Created by 高瑞浩 on 2017/3/14.
//  Copyright © 2017年 高瑞浩. All rights reserved.
//

#import "GHHPhotoEditingViewController.h"
#import "UIView+Addition.h"
#import "GHHPhotoManager.h"

@interface GHHPhotoEditingViewController ()

@property(nonatomic, strong)PHAsset *asset;
@property(nonatomic, strong)GHHPhotoManager *manager;
@property(nonatomic, strong)AVAsset *avasset;
@property(nonatomic, strong)AVAssetImageGenerator *generator;
@property(nonatomic, strong)NSMutableArray *testArray;

@property(nonatomic, strong)UIImageView *imageView;

@end

@implementation GHHPhotoEditingViewController

- (instancetype)initWithAsset:(PHAsset *)asset {
    self = [super init];
    if (self) {
        self.asset = asset;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.manager = [[GHHPhotoManager alloc] init];
    self.avasset = [self.manager requestVideoWithAsset:self.asset];
    self.generator = [[AVAssetImageGenerator alloc] initWithAsset:self.avasset];
    self.generator.appliesPreferredTrackTransform=TRUE;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.view.height - self.view.width) / 2, self.view.width, self.view.width)];
    __weak typeof(self) weakSelf = self;
    [self.manager getImageFromAsset:self.asset targetSize:CGSizeMake(self.view.width, self.view.width) completeHandler:^(UIImage *image) {
        weakSelf.imageView.image = image;
    }];
    [self.view addSubview:self.imageView];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, self.view.height - 100, self.view.width - 40, 100)];
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    slider.maximumValue = self.asset.duration;
    slider.minimumValue = 0.0;
    [self.view addSubview:slider];
    
    CGFloat i = 0;
    self.testArray = [NSMutableArray array];
    while (i < self.asset.duration) {
        UIImage *image = [self thumbnailImageAtTime:i];
        [self.testArray addObject:image];
        i += 0.1;
    }
    
}

- (void)sliderValueChanged:(UISlider *)sender {
    int index = sender.value * 10;
    NSLog(@"🐶🐶🐶       %d", index);
    self.imageView.image = self.testArray[index];
    
//    CMTime thumbTime = CMTimeMakeWithSeconds(sender.value,30);
//    NSLog(@"🐶🐶🐶 %f", sender.value);
//    
//    AVAssetImageGeneratorCompletionHandler handler =
//    ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
//        if (result != AVAssetImageGeneratorSucceeded) {       }//没成功
//        
//        UIImage *thumbImg = [UIImage imageWithCGImage:im];
//        
//        [self performSelectorOnMainThread:@selector(movieImage:) withObject:thumbImg waitUntilDone:YES];
//        
//    };
//    
//    [self.generator generateCGImagesAsynchronouslyForTimes:
//     [NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];
}

- (UIImage *)thumbnailImageAtTime:(NSTimeInterval)playbackTime
{
    NSLog(@"🐶🐶🐶 %f", playbackTime);
    CGImageRef imageRef = [self.generator copyCGImageAtTime:CMTimeMakeWithSeconds(playbackTime, 600) actualTime:NULL error:nil];
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

- (void)movieImage:(UIImage *)image {
    self.imageView.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
