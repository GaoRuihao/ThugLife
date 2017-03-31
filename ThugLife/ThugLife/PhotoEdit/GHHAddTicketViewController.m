//
//  GHHAddTicketViewController.m
//  ThugLife
//
//  Created by 高瑞浩 on 2017/3/30.
//  Copyright © 2017年 高瑞浩. All rights reserved.
//

#import "GHHAddTicketViewController.h"
#import "UIView+Addition.h"
#import "AnimationAddViewController.h"

@interface GHHAddTicketViewController ()<UIScrollViewDelegate>

@property(nonatomic, assign)CGPoint zoomCenter;
@property(nonatomic, assign)CGFloat zoomScale;

@property(nonatomic, strong)UIImage *editImage;
@property(nonatomic, strong)UIImageView *imageView;

@end

@implementation GHHAddTicketViewController

- (instancetype)initWithPoint:(CGPoint)zoomCenter image:(UIImage *)image zoomScale:(CGFloat)scale {
    self = [super init];
    if (self) {
        self.zoomCenter = zoomCenter;
        self.editImage = image;
        self.zoomScale = scale;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加贴纸";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    
    UIScrollView *imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(4, 4, self.view.width - 8, self.view.height - 72)];
    imageScrollView.delegate = self;
//    imageScrollView.userInteractionEnabled = NO;
    imageScrollView.maximumZoomScale = 3.0;
    imageScrollView.minimumZoomScale = 1.0;
    [self.view addSubview:imageScrollView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:imageScrollView.bounds];
    self.imageView.image = self.editImage;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageScrollView addSubview:self.imageView];
    CGFloat xsize = imageScrollView.width / self.zoomScale;
    CGFloat ysize = imageScrollView.height / self.zoomScale;
    [imageScrollView zoomToRect:CGRectMake(self.zoomCenter.x - xsize, self.zoomCenter.y - ysize, xsize, ysize) animated:NO];
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.view.height - 150 - 64, self.view.width, 150)];
    scrollview.contentSize = CGSizeMake(self.view.width * 14, 150);
    scrollview.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    scrollview.pagingEnabled = YES;
    [self.view addSubview:scrollview];
    
    CGFloat tWidth = self.view.width / 5;
    for (int i = 0; i < 140; i++) {
        int page = i / 10;
        int row = i % 10 / 5;
        int index = i % 10 % 5;
        UIImageView *ticketImageView = [[UIImageView alloc] initWithFrame:CGRectMake(page * self.view.width + index * tWidth, row * 72.5 + 5, tWidth, 67.5)];
        ticketImageView.contentMode = UIViewContentModeScaleAspectFit;
        ticketImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"l%d", i+1]];
        [scrollview addSubview:ticketImageView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightItemAction:(id)sender {
    AnimationAddViewController *addVC = [[AnimationAddViewController alloc] initWithPoint:self.zoomCenter image:self.editImage];
    addVC.avAsset = self.avAsset;
    addVC.choosedTime = self.choosedTime;
    [self.navigationController pushViewController:addVC animated:YES];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
