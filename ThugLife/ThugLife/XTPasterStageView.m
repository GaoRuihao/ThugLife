//
//  XTPasterStageView.m
//  XTPasterManager
//
//  Created by apple on 15/7/8.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "XTPasterStageView.h"
#import "XTPasterView.h"
#import "UIImage+AddFunction.h"

#define APPFRAME    [UIScreen mainScreen].bounds

@interface XTPasterStageView () <XTPasterViewDelegate>
{
    CGPoint         startPoint ;
    CGPoint         touchPoint ;
}

@property (nonatomic,strong) UIButton       *bgButton ;
@property (nonatomic,strong) UIImageView    *imgView ;
@property (nonatomic,strong) XTPasterView   *pasterCurrent ;
@property (nonatomic)        int            newPasterID ;
@property (nonatomic, strong)NSMutableArray  *m_listPaster;

@end

@implementation XTPasterStageView

- (void)setOriginImage:(UIImage *)originImage
{
    _originImage = originImage ;
    
    self.imgView.image = originImage ;
}

- (int)newPasterID
{
    _newPasterID++ ;
    
    return _newPasterID ;
}

- (void)setPasterCurrent:(XTPasterView *)pasterCurrent
{
    _pasterCurrent = pasterCurrent ;
    
    [self bringSubviewToFront:_pasterCurrent] ;
}

- (UIButton *)bgButton
{
    if (!_bgButton) {
        _bgButton = [[UIButton alloc] initWithFrame:self.frame] ;
        _bgButton.tintColor = nil ;
        _bgButton.backgroundColor = nil ;
        [_bgButton addTarget:self
                      action:@selector(backgroundClicked:)
            forControlEvents:UIControlEventTouchUpInside] ;
        if (![_bgButton superview]) {
            [self addSubview:_bgButton] ;
        }
    }
    
    return _bgButton ;
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:self.frame] ;
        _imgView.contentMode = UIViewContentModeScaleAspectFit ;
        
        if (![_imgView superview])
        {
            [self addSubview:_imgView] ;
        }
    }
    
    return _imgView ;
}

#pragma mark - initial
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.m_listPaster = [[NSMutableArray alloc] initWithCapacity:1] ;
        [self imgView] ;
        [self bgButton] ;
    }
    
    return self;
}

#pragma mark - public
- (void)addPasterWithImg:(UIImage *)imgP
{
    [self clearAllOnFirst] ;
    self.pasterCurrent = [[XTPasterView alloc] initWithBgView:self
                                                     pasterID:self.newPasterID
                                                          img:imgP] ;
    _pasterCurrent.delegate = self ;
    [self.m_listPaster addObject:_pasterCurrent] ;
}

- (UIImage *)doneEdit
{
//    NSLog(@"done") ;
    [self clearAllOnFirst] ;
    
//    NSLog(@"self.originImage.size : %@",NSStringFromCGSize(self.originImage.size)) ;
    CGFloat org_width = self.originImage.size.width ;
    CGFloat org_heigh = self.originImage.size.height ;
    CGFloat rateOfScreen = org_width / org_heigh ;
    CGFloat inScreenH = self.frame.size.width / rateOfScreen ;
    
    CGRect rect = CGRectZero ;
    rect.size = CGSizeMake(APPFRAME.size.width, inScreenH) ;
    rect.origin = CGPointMake(0, (self.frame.size.height - inScreenH) / 2) ;
    
    UIImage *imgTemp = [UIImage getImageFromView:self] ;
//    NSLog(@"imgTemp.size : %@",NSStringFromCGSize(imgTemp.size)) ;
    
    UIImage *imgCut = [UIImage squareImageFromImage:imgTemp scaledToSize:rect.size.width] ;
    
    return imgCut ;
}


- (void)backgroundClicked:(UIButton *)btBg
{
    NSLog(@"back clicked") ;
    
    [self clearAllOnFirst] ;
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        ((UIScrollView *)self.superview).scrollEnabled = YES;
    }
}

- (void)clearAllOnFirst
{
    _pasterCurrent.isOnFirst = NO ;
    
    [self.m_listPaster enumerateObjectsUsingBlock:^(XTPasterView *pasterV, NSUInteger idx, BOOL * _Nonnull stop) {
         pasterV.isOnFirst = NO ;
    }] ;
}

#pragma mark - PasterViewDelegate
- (void)makePasterBecomeFirstRespond:(int)pasterID ;
{
    [self.m_listPaster enumerateObjectsUsingBlock:^(XTPasterView *pasterV, NSUInteger idx, BOOL * _Nonnull stop) {
        
        pasterV.isOnFirst = NO ;

        if (pasterV.pasterID == pasterID)
        {
            self.pasterCurrent = pasterV ;
            pasterV.isOnFirst = YES ;
        }
        
    }] ;
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        ((UIScrollView *)self.superview).scrollEnabled = NO;
    }
}

- (void)removePaster:(int)pasterID
{
    [self.m_listPaster enumerateObjectsUsingBlock:^(XTPasterView *pasterV, NSUInteger idx, BOOL * _Nonnull stop) {
        if (pasterV.pasterID == pasterID)
        {
            [self.m_listPaster removeObjectAtIndex:idx] ;
            *stop = YES ;
        }
    }] ;
}

@end

