//
//  AnimationAddViewController.h
//  ThugLife
//
//  Created by 高瑞浩 on 2017/3/21.
//  Copyright © 2017年 高瑞浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationAddViewController : BaseViewController

@property(nonatomic)NSTimeInterval choosedTime;
@property(nonatomic, strong)AVURLAsset *avAsset;
@property(nonatomic, copy)NSMutableArray *ticketsArray;

- (instancetype)initWithPoint:(CGPoint)zoomCenter image:(UIImage *)image;

@end
