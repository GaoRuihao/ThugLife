//
//  GHHAddTicketViewController.h
//  ThugLife
//
//  Created by 高瑞浩 on 2017/3/30.
//  Copyright © 2017年 高瑞浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHHAddTicketViewController : BaseViewController

@property(nonatomic)NSTimeInterval choosedTime;
@property(nonatomic, strong)AVURLAsset *avAsset;

- (instancetype)initWithPoint:(CGPoint)zoomCenter image:(UIImage *)image zoomScale:(CGFloat)scale;

@end
