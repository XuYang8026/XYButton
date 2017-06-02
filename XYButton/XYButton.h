//
//  XYButton.h
//  KeepBtn
//
//  Created by 徐阳 on 2017/6/2.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)(UIButton *btn);//

@interface XYButton : UIButton
@property (nonatomic ,assign)BOOL isCanTapWhenAnimating;//在动画期间是否可以再次被点击 默认否

/**
 圆形按钮

 @param frame frame
 @param backgroundColor 背景颜色
 @param borderColor 边框颜色
 @param title 标题
 @param titleColor 标题颜色
 @param font 字体
 @param tapBlock 点击事件block
 */
-(instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font tapBlock:(TapBlock) tapBlock;
@end
