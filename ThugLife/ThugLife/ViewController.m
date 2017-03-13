//
//  ViewController.m
//  ThugLife
//
//  Created by 高瑞浩 on 2017/3/13.
//  Copyright © 2017年 高瑞浩. All rights reserved.
//

#import "ViewController.h"
#import "GHHPhotoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"浩哥的Thug Life";
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectAlbumAction:(id)sender {
    GHHPhotoViewController *photoVC = [[GHHPhotoViewController alloc] initWithMaxCount:9 completedHandler:^(NSArray *array) {
        
    }];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:photoVC];
    [self presentViewController:navi animated:YES completion:nil];
//    [self.navigationController pushViewController:photoVC animated:YES];
}

@end
