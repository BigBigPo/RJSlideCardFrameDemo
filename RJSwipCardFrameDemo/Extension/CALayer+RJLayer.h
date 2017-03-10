//
//  CALayer+RJLayer.h
//  test
//
//  Created by Po on 16/3/2.
//  Copyright © 2016年 Po. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (RJLayer)
/**
 *  @brief  设置边框颜色（ 方便XIB中设置边框颜色）
 *  @param mBorderColor 边框颜色
 */
- (void)setMBorderColor:(UIColor *)mBorderColor;

/**
 *  @brief 设置指定圆角位置
 *
 *  @param cornerRadius 圆角大小
 *  @param rectCorner   圆角位置
 */
- (void)setCornerRadius:(CGFloat)cornerRadius
         withRectCorner:(UIRectCorner)rectCorner;

- (void)setShadowWithColor:(UIColor *)color
                    Offset:(CGSize)offset
                   opacity:(CGFloat)opacity
                    radius:(CGFloat)radius;
@end
