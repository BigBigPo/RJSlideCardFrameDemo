//
//  ViewController.m
//  test
//
//  Created by Po on 16/8/5.
//  Copyright © 2016年 Po. All rights reserved.
//

#import "ViewController.h"
#import "HomeVC.h"
#import "HomeGroupVC.h"
#import "HomeListVC.h"

#import "CALayer+RJLayer.h"
#import "CT_pch.h"
@interface ViewController ()
@property (strong, nonatomic) HomeVC * homeVC;
@property (strong, nonatomic) HomeGroupVC * homeGroupVC;
@property (strong, nonatomic) HomeListVC * homeListVC;

@property (assign, nonatomic) CGFloat vcMargin;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initInterface];
    
}

- (void)initData {
    _vcMargin = 20;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homePanPointNotification:) name:@"CTHomeVCPanPoint" object:nil];
}

- (void)initInterface {
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self configSubVC];
}

- (void)homePanPointNotification:(NSNotification *)notification {
    NSDictionary * userInfo = notification.userInfo;
    NSString * state = userInfo[@"state"];
    if ([state isEqualToString:@"change"]) {
        CGPoint point = [userInfo[@"point"] CGPointValue];
        [self moveSubVCWithX:point.x isEnd:NO];
    } else if ([state isEqualToString:@"end"]) {
        [self moveSubVCWithX:0 isEnd:YES];
    }
}

- (void)viewDidLayoutSubviews {
    [_homeGroupVC.view.layer setCornerRadius:10 withRectCorner:UIRectCornerTopLeft | UIRectCornerBottomLeft];
    [_homeListVC.view.layer setCornerRadius:10 withRectCorner:UIRectCornerTopRight | UIRectCornerBottomRight];
}

#pragma mark - setter
- (void)configSubVC {
    _homeGroupVC = [[HomeGroupVC alloc] init];
    [_homeGroupVC.view setFrame:CGRectMake(-SCWidth, 0, SCWidth, SCHeight)];
    [self.view addSubview:_homeGroupVC.view];
    [self addChildViewController:_homeGroupVC];
    
    _homeListVC = [[HomeListVC alloc] init];
    [_homeListVC.view setFrame:CGRectMake(SCWidth, 0, SCWidth, SCHeight)];
    [self.view addSubview:_homeListVC.view];
    [self addChildViewController:_homeListVC];
    
    _homeVC = [[HomeVC alloc] init];
    [_homeVC.view setFrame:self.view.bounds];
    [self.view addSubview:_homeVC.view];
    [self addChildViewController:_homeVC];
}

- (void)moveSubVCWithX:(CGFloat)x isEnd:(BOOL)isEnd{
    if (isEnd) {
        CGFloat homeX = _homeVC.view.frame.origin.x;
        if (homeX < (-SCWidth / 2)) {
            [self showSubViewWithCount:RJDirectionRight];
        } else if((homeX >= (-SCWidth / 2)) && (homeX <= (SCWidth / 2))) {
            [self showSubViewWithCount:RJDirectionCenter];
        } else {
            [self showSubViewWithCount:RJDirectionLeft];
        }
    } else {
        NSMutableArray * xArray = [NSMutableArray array];
        for (UIView * view in @[_homeVC.view, _homeGroupVC.view, _homeListVC.view]) {
            CGFloat xPoint = view.frame.origin.x;
            xPoint += x;
            [xArray addObject:@(xPoint)];
        }
        [self setSubVCWithX:xArray animation:NO];
    }
}

/**center：0， left：1， right：2*/
- (void)showSubViewWithCount:(RJDirection)direction {
    
    CGFloat x1, x2, x3;
    if (direction == RJDirectionCenter) {
        x1 = 0;
        x2 = -SCWidth;
        x3 = SCWidth;
    } else if (direction == RJDirectionLeft) {
        x2 = 0;
        x1 = SCWidth - _vcMargin * 2;
        x3 = x1 + SCWidth;
    } else if (direction == RJDirectionRight) {
        x3 = 0;
        x1 = _vcMargin * 2 - SCWidth;
        x2 = x1 - SCWidth;
    }
    [self setSubVCWithX:@[@(x1), @(x2), @(x3)] animation:YES];
}

- (void)setSubVCWithX:(NSArray *)xArray animation:(BOOL)animation{
    if (xArray.count != 3) {
        return;
    }
    
    //center
    CGFloat x1 = [xArray[0] floatValue];
    CGRect rect1 = CGRectMake(x1, 0, SCWidth, SCHeight);
    //left
    CGFloat x2 = [xArray[1] floatValue];
    CGFloat percent2 = 1 - (fabs(x2) / (SCWidth));
    CGFloat y2 = percent2 * _vcMargin;
    CGRect rect2 = CGRectMake(x2, y2, SCWidth, SCHeight - y2 * 2);
    //right
    CGFloat x3 = [xArray[2] floatValue];
    CGFloat percent3 = fabs(x3 - SCWidth) / (SCWidth);
    CGFloat y3 = percent3 * _vcMargin;
    CGRect rect3 = CGRectMake(x3, y3, SCWidth, SCHeight - y3 * 2);
    
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            [_homeVC.view setFrame:rect1];
            [_homeGroupVC.view setFrame:rect2];
            [_homeListVC.view setFrame:rect3];
            [_homeGroupVC.navHeight setConstant:64 - y2];
            [_homeListVC.navHeight setConstant:64 - y3];
            [self.view layoutIfNeeded];
        }];
    } else {
        [_homeVC.view setFrame:rect1];
        [_homeGroupVC.view setFrame:rect2];
        [_homeListVC.view setFrame:rect3];
        [_homeGroupVC.navHeight setConstant:64 - y2];
        [_homeListVC.navHeight setConstant:64 - y3];
    }
    
}

@end
