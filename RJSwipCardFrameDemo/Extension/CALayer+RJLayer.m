//
//  CALayer+RJLayer.m
//  test
//
//  Created by Po on 16/3/2.
//  Copyright © 2016年 Po. All rights reserved.
//

#import "CALayer+RJLayer.h"

@implementation CALayer (RJLayer)
- (void)setMBorderColor:(UIColor *)mBorderColor
{
    self.borderColor = mBorderColor.CGColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
         withRectCorner:(UIRectCorner)rectCorner {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.mask = maskLayer;
}

- (void)setShadowWithColor:(UIColor *)color
                    Offset:(CGSize)offset
                   opacity:(CGFloat)opacity
                    radius:(CGFloat)radius {
    self.shadowColor = color.CGColor;//shadowColor阴影颜色
    self.shadowOffset = offset;//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.shadowOpacity = opacity;//阴影透明度
    self.shadowRadius = radius;//阴影半径
}
@end
