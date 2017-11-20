//
//  ViewController.m
//  MapleLeafAnimation
//
//  Created by xrh on 2017/11/20.
//  Copyright © 2017年 xrh. All rights reserved.
//

#import "ViewController.h"
#import "LeapProgressView.h"

@interface ViewController ()
@property (strong, nonatomic) LeapProgressView *progress;
@property (assign, nonatomic) CGFloat rate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];
    
    self.progress = [[LeapProgressView alloc]initWithFrame:CGRectMake(66, 200, 248, 35)];
    [self.view addSubview:_progress];
    
    [_progress startLoading];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _rate += 0.01;
    
    [_progress setProgress:_rate];
    if (_rate >= 0.99) {
        _rate = 0;
        [_progress stopLoading];
    }
}

@end
