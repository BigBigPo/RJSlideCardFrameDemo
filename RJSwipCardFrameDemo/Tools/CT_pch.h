//
//  RJPhotoPickerPCH.h
//  RJPhotoPicker_OC
//
//  Created by Po on 16/7/27.
//  Copyright © 2016年 Po. All rights reserved.
//
#import <UIKit/UIKit.h>

#ifndef CT_pch_h
#define CT_pch_h

#define SCBounds [UIScreen mainScreen].bounds.size
#define SCHeight [UIScreen mainScreen].bounds.size.height
#define SCWidth [UIScreen mainScreen].bounds.size.width

/**建立当前类的weakSelf*/
#define WSelf __weak typeof(self) weakSelf = self;

/**获取Color*/
#define RJRGB(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define sysWindow [[[UIApplication sharedApplication] delegate] window]
//

#endif /* RJPhotoPickerPCH_h */

typedef NS_ENUM(NSInteger, RJDirection) {
    RJDirectionUp = 0,
    RJDirectionLeft,
    RJDirectionDown,
    RJDirectionRight,
    RJDirectionCenter
};
