//
//  HomeVC.m
//  test
//
//  Created by Po on 16/8/5.
//  Copyright © 2016年 Po. All rights reserved.
//

#import "HomeVC.h"
#import "MsgView.h"

#import "RJControl.h"
#import "CALayer+RJLayer.h"
#import "CT_pch.h"
@interface HomeVC ()
@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet MsgView *msgView;
@property (weak, nonatomic) IBOutlet RJControl *msgControl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottom;
@property (assign, nonatomic) CGPoint lastPanPoint;
@property (assign, nonatomic) BOOL isMsgListShow;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initInterface];

}
- (void)viewDidLayoutSubviews {
    [_navView.layer setCornerRadius:10 withRectCorner:UIRectCornerTopRight | UIRectCornerTopLeft];

    [_msgView.tableView setFrame:_msgView.bounds];
    if (!_isMsgListShow) {
        [_bottomView.layer setCornerRadius:10 withRectCorner:UIRectCornerBottomLeft | UIRectCornerBottomRight];
    } else {
        [_bottomView.layer setCornerRadius:0 withRectCorner:UIRectCornerBottomLeft | UIRectCornerBottomRight];
    }
    
}
#pragma mark - user-define initialization
- (void)initData {
    _isMsgListShow = NO;
}

- (void)initInterface {
    [self.view.layer setCornerRadius:10];
    [self.view.layer setShadowWithColor:[UIColor blackColor] Offset:CGSizeMake(0, 0) opacity:0.5 radius:8];
    
    [self configMsgControl];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:pan];
}

- (void)doRequest {
    
}

#pragma mark - event
- (void)panGesture:(UIPanGestureRecognizer *)gesture {
    if (_isMsgListShow) {
        return;
    }
    CGPoint point = [gesture translationInView:self.view];
    if ((gesture.state == UIGestureRecognizerStateBegan)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CTHomeVCPanPoint" object:nil userInfo:@{@"state":@"began"}];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CTHomeVCPanPoint" object:nil userInfo:@{@"state":@"change",@"point":[NSValue valueWithCGPoint:CGPointMake(point.x - _lastPanPoint.x, point.y - _lastPanPoint.y)]}];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CTHomeVCPanPoint" object:nil userInfo:@{@"state":@"end"}];
    }
    _lastPanPoint = point;
}

- (IBAction)pressMSGButton:(UIButton *)sender {
    CGFloat y;
    if (_isMsgListShow) {
        y = 0;
    } else {
        y = SCHeight - 64 - _bottomView.frame.size.height;
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [_bottomViewBottom setConstant:y];
        _isMsgListShow = !_isMsgListShow;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            [_msgControl setHidden:!_isMsgListShow];
        }
    }];
}

#pragma mark - setter
- (void)configMsgControl {
    [_msgControl setTrackingBlock:^(BOOL stop, RJDirection direction, CGPoint changeValue) {
        if (stop) {
            CGFloat y;
            if (_bottomViewBottom.constant >= SCHeight / 2) {
                y = SCHeight - 64 - _bottomView.frame.size.height;
                _isMsgListShow = YES;
            } else {
                y = 0;
                _isMsgListShow = NO;
            }
            
            [UIView animateWithDuration:0.3 animations:^{
                [_bottomViewBottom setConstant:y];
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                if (finished) {
                    [_msgControl setHidden:!_isMsgListShow];
                }
            }];
        } else {
            CGFloat y = _bottomViewBottom.constant - changeValue.y;
            [_bottomViewBottom setConstant:y];
        }
    }];
}

@end
