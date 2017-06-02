//
//  XYButton.m
//  KeepBtn
//
//  Created by 徐阳 on 2017/6/2.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "XYButton.h"

#define LineWidth (self.frame.size.width * 0.023)
#define KDuration 0.15
#define KDurationFast 0.06

@interface XYButton()

@property (nonatomic, strong) CAShapeLayer *borderLayer;//边框
@property (nonatomic, strong) CAShapeLayer *bgLayer;//边框


@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, copy) TapBlock block;//点击事件

@end

@implementation XYButton

#pragma mark ————— 初始化 —————
-(instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font tapBlock:(TapBlock) tapBlock{
    if (self = [super initWithFrame:frame]) {
        self.block = tapBlock;
        self.bgColor = backgroundColor;
        self.borderColor = borderColor;
        
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = font;
        [self addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchCancel];
        [self addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchUpOutside];
        
        
        [self.layer insertSublayer:self.bgLayer atIndex:0];
        [self.layer insertSublayer:self.borderLayer above:self.bgLayer];
        
    }
    return self;
}
#pragma mark ————— 按下 —————
-(void)touchDown:(UIButton *)btn{
    self.enabled = _isCanTapWhenAnimating ? YES : NO ;
    [self downAnimation];
}
#pragma mark ————— 松开 —————
-(void)touchUpInside:(UIButton *)btn{
    [self upAnimation:NO];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.block) {
            self.block(nil);
        }
        self.enabled = YES;
    });
}
#pragma mark ————— 取消 —————
-(void)touchCancel:(UIButton *)btn{
    self.enabled = YES;
    [self upAnimation:YES];
}

#pragma mark ————— 按下动画 —————
-(void)downAnimation{
    
    CABasicAnimation *bgAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    bgAnimation.toValue = @1.1;
    bgAnimation.duration = KDuration;
    bgAnimation.removedOnCompletion=NO;
    bgAnimation.fillMode=kCAFillModeForwards;
    [self.bgLayer addAnimation:bgAnimation forKey:nil];
    
    CABasicAnimation *borderAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    borderAnimation.toValue = @0.9;
    borderAnimation.duration = KDuration;
    borderAnimation.removedOnCompletion=NO;
    borderAnimation.fillMode=kCAFillModeForwards;
    [self.borderLayer addAnimation:borderAnimation forKey:nil];
    
}

#pragma mark ————— 松开动画 —————
-(void)upAnimation:(BOOL) isCancel{
    if (!isCancel) {//如果不是取消，做个动画再还原；如果是取消，直接还原
        
        CABasicAnimation *bgBig0 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        bgBig0.toValue = @1.05;
        bgBig0.duration = KDurationFast;
        bgBig0.removedOnCompletion=NO;
        bgBig0.fillMode=kCAFillModeForwards;
        bgBig0.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.bgLayer addAnimation:bgBig0 forKey:nil];
        
        CABasicAnimation *bgBig = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        bgBig.toValue = @1.15;
        bgBig.duration = KDuration;
        bgBig.beginTime =CACurrentMediaTime() +KDurationFast;
        bgBig.removedOnCompletion=NO;
        bgBig.fillMode=kCAFillModeForwards;
        bgBig.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.bgLayer addAnimation:bgBig forKey:nil];
        
        
        CABasicAnimation *bgSmall = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        bgSmall.toValue = @1.0;
        bgSmall.beginTime =CACurrentMediaTime() + KDuration + KDurationFast ;
        bgSmall.duration =  0.1;
        bgSmall.removedOnCompletion=NO;
        bgSmall.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        bgSmall.fillMode=kCAFillModeForwards;
        [self.bgLayer addAnimation:bgSmall forKey:nil];
        
        
        CABasicAnimation *borderBig = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        borderBig.toValue = @0.85;
        borderBig.duration = KDuration;
        borderBig.beginTime =CACurrentMediaTime() +KDurationFast;
        borderBig.removedOnCompletion=NO;
        borderBig.fillMode=kCAFillModeForwards;
        borderBig.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.borderLayer addAnimation:borderBig forKey:nil];
        
        CABasicAnimation *borderSmall = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        borderSmall.toValue = @1.0;
        borderSmall.duration = 0.1;
        borderSmall.beginTime =CACurrentMediaTime() +KDuration + KDurationFast;
        borderSmall.removedOnCompletion=NO;
        borderSmall.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        borderSmall.fillMode=kCAFillModeForwards;
        [self.borderLayer addAnimation:borderSmall forKey:nil];
        
    }else{
        CABasicAnimation *bgAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        bgAnimation.toValue = @1.0;
        bgAnimation.duration = KDuration;
        bgAnimation.removedOnCompletion=NO;
        bgAnimation.fillMode=kCAFillModeForwards;
        [self.bgLayer addAnimation:bgAnimation forKey:nil];
        
        CABasicAnimation *borderAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        borderAnimation.toValue = @1.0;
        borderAnimation.duration = KDuration;
        borderAnimation.removedOnCompletion=NO;
        borderAnimation.fillMode=kCAFillModeForwards;
        [self.borderLayer addAnimation:borderAnimation forKey:nil];
    }
    
}

#pragma mark - ——————— 懒加载 layer ————————
-(CAShapeLayer *)bgLayer{
    if(!_bgLayer){
        _bgLayer = [CAShapeLayer new];
        _bgLayer.frame = self.bounds;
        _bgLayer.backgroundColor = self.bgColor.CGColor;
        _bgLayer.cornerRadius = self.bounds.size.width/2;
        
    }
    return _bgLayer;
}

-(CAShapeLayer *)borderLayer{
    if (!_borderLayer) {
        
        _borderLayer = [CAShapeLayer new];
        _borderLayer.borderWidth = LineWidth;
        _borderLayer.borderColor = self.borderColor.CGColor;
        _borderLayer.frame = CGRectMake(LineWidth, LineWidth, self.frame.size.width-(LineWidth*2), self.frame.size.height-(LineWidth*2));
        _borderLayer.cornerRadius = _borderLayer.frame.size.width/2;
    }
    return _borderLayer;
}


@end
