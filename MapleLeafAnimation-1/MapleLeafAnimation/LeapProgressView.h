//
//  LeapProgressView.h
//  MapleLeafAnimation
//
//  Created by xrh on 2017/11/20.
//  Copyright © 2017年 xrh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeapProgressView : UIView

- (void)startLoading;
- (void)stopLoading;

- (void)setProgress:(CGFloat)rate;

@end
