//
//  LeapProgressView.m
//  MapleLeafAnimation
//
//  Created by xrh on 2017/11/20.
//  Copyright © 2017年 xrh. All rights reserved.
//

#import "LeapProgressView.h"

@interface LeapProgressView()<CAAnimationDelegate>
@property (strong, nonatomic) UIImageView *flowerView;
@property (strong, nonatomic) UIImageView *progressImageView;
@property (strong, nonatomic) UIImageView *progressBGImageView;
@property (strong, nonatomic) UILabel *textLabel;
@end

@implementation LeapProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    /**
     它的功能是创建一个内容可拉伸，而边角不拉伸的图片，需要两个参数，第一个是左边不拉伸区域的宽度，第二个参数是上面不拉伸的高度。
     */
    bgImageView.image = [[UIImage imageNamed:@"bg"] stretchableImageWithLeftCapWidth:124/2.0f topCapHeight:35/2.0];
    [self addSubview:bgImageView];
    
    self.flowerView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 32, 2, 30, 30)];
    self.flowerView.image = [UIImage imageNamed:@"flower"];
    [self addSubview:self.flowerView];
    
    self.progressBGImageView = [[UIImageView alloc]initWithFrame:CGRectMake(4, 6.2, self.frame.size.width - 8 - 30, 24)];
    _progressBGImageView.contentMode     = UIViewContentModeLeft;
    _progressBGImageView.backgroundColor = [UIColor clearColor];
    _progressBGImageView.clipsToBounds   = YES;
    [self addSubview:_progressBGImageView];
    
    self.progressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 6.2, 0, 24)];
    _progressImageView.image = [[UIImage imageNamed:@"progress"] stretchableImageWithLeftCapWidth:86/2.0 topCapHeight:24/2.0];
    _progressImageView.contentMode = UIViewContentModeLeft;
    _progressImageView.clipsToBounds = YES;
    [self addSubview:_progressImageView];
    
    self.textLabel = [[UILabel alloc] initWithFrame:_flowerView.frame];
    _textLabel.text = @"100\%";
    _textLabel.textColor = [UIColor whiteColor];
    _textLabel.font = [UIFont boldSystemFontOfSize:11];
    _textLabel.hidden = YES;
    [self addSubview:_textLabel];
    
}

- (void)startLoading {
    //花瓣转动
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotateAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    /**
     CATransform3DRotate的参数(CATransform3D t, CGFloat angle,
     CGFloat x, CGFloat y, CGFloat z)
        CATransform3D   view.layer的transform
        angle           旋转的角度
        x,y,z           以0~1为分界，谁为正，就以谁为轴旋转
     */
    rotateAnimation.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(_flowerView.layer.transform, M_PI, 0, 0, 1)];
    rotateAnimation.cumulative = YES;
    rotateAnimation.duration   = 0.5;
    rotateAnimation.repeatCount = MAXFLOAT;
    [self.flowerView.layer addAnimation:rotateAnimation forKey:@"flowerAnimation"];
}

- (void)stopLoading {
    [_flowerView.layer removeAllAnimations];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1;
    scaleAnimation.toValue   = @0;
    scaleAnimation.duration  = 0.5;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode  = kCAFillModeForwards;
    [self.flowerView.layer addAnimation:scaleAnimation forKey:nil];
    
    _textLabel.hidden = NO;
    scaleAnimation.fromValue = @0;
    scaleAnimation.toValue   = @1;
    [_textLabel.layer addAnimation:scaleAnimation forKey:nil];
}

- (void)setProgress:(CGFloat)rate {
    
    
    //树叶效果
    CALayer *leafLayer = [CALayer layer];
    leafLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"leaf"].CGImage);//提供层的内容的对象
    leafLayer.bounds   = CGRectMake(0, 0, 10, 10);
    leafLayer.position = CGPointMake(_progressBGImageView.frame.origin.x + _progressBGImageView.frame.size.width, 8);
    [self.progressBGImageView.layer addSublayer:leafLayer];
    
    //树叶开始动画
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *p1 = [NSValue valueWithCGPoint:leafLayer.position];
    NSValue *p2 = [NSValue valueWithCGPoint:CGPointMake(_progressBGImageView.frame.origin.x + _progressBGImageView.frame.size.width*3/4.0 + arc4random()%(int)(_progressBGImageView.frame.size.width/4.0), _progressBGImageView.frame.origin.y + arc4random()%(int)_progressBGImageView.frame.size.height)];
    NSValue *p3 = [NSValue valueWithCGPoint:CGPointMake(_progressBGImageView.frame.origin.x + _progressBGImageView.frame.size.width/2.0 + arc4random()%(int)(_progressBGImageView.frame.size.width/4.0), _progressBGImageView.frame.origin.y + arc4random()%(int)_progressBGImageView.frame.size.height)];
    NSValue *p4 = [NSValue valueWithCGPoint:CGPointMake(_progressBGImageView.frame.origin.x + _progressBGImageView.frame.size.width/4.0 + arc4random()%(int)(_progressBGImageView.frame.size.width/4.0), _progressBGImageView.frame.origin.y + arc4random()%(int)_progressBGImageView.frame.size.height)];
    NSValue *p5 = [NSValue valueWithCGPoint:CGPointMake(_progressBGImageView.frame.origin.x+5, _progressBGImageView.frame.origin.y + arc4random()%(int)_progressBGImageView.frame.size.height)];
    keyAnimation.values = @[p1, p2, p3, p4, p5];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.fromValue = @0;
    rotateAnimation.toValue   = @(M_PI/18.0 * (arc4random()%(36*6) ));
    
    CAAnimationGroup  *group = [CAAnimationGroup animation];
    group.animations = @[rotateAnimation, keyAnimation];
    group.duration = 8;
    group.delegate = self;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    [group setValue:leafLayer forKey:@"leafLayer"];
    
    [leafLayer addAnimation:group forKey:nil];
    
    //加载中。。。。。
    self.progressImageView.frame = CGRectMake(_progressImageView.frame.origin.x, _progressImageView.frame.origin.y, _progressBGImageView.frame.size.width * rate, _progressImageView.frame.size.height);
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CALayer *layer = [anim valueForKey:@"leafLayer"];
    [layer removeFromSuperlayer];
}

@end
