//
//  MsgView.m
//  test
//
//  Created by Po on 16/8/5.
//  Copyright © 2016年 Po. All rights reserved.
//

#import "MsgView.h"
@interface MsgView ()
@property (weak, nonatomic) IBOutlet UIView * view;



@end

@implementation MsgView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"MsgView" owner:self options:nil];
        [self addSubview:self.view];
        [self.view setFrame:self.bounds];
        [_tableView setFrame:self.bounds];
        
        UIGestureRecognizer * gesture = [[UIGestureRecognizer alloc] init];
        [self addGestureRecognizer:gesture];
        
    }
    return self;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return NO;
}
@end
