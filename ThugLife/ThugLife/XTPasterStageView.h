//
//  XTPasterStageView.h
//  XTPasterManager
//
//  Created by apple on 15/7/8.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTPasterStageView : UIView

@property (nonatomic,strong) UIImage *originImage;
@property (nonatomic, readonly, strong)NSMutableArray  *m_listPaster;

- (instancetype)initWithFrame:(CGRect)frame ;
- (void)addPasterWithImg:(UIImage *)imgP ;
- (UIImage *)doneEdit ;

@end
