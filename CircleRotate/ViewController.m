//
//  ViewController.m
//  CircleRotate
//
//  Created by 张奥 on 2019/8/17.
//  Copyright © 2019年 张奥. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>
@property (nonatomic, strong)UIImageView *rotateImg;
@property (nonatomic, assign)NSInteger circleAngle;
@property (nonatomic, assign)BOOL isAnimation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _circleAngle = 0;
    UIImageView *rotateImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou_up_w"]];
    self.rotateImg = rotateImg;
    rotateImg.frame = CGRectMake(0, 0, 54, 54);
    rotateImg.center = self.view.center;
    rotateImg.layer.anchorPoint = CGPointMake(0.5, 1);
    [self.view addSubview:rotateImg];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(80, 100, 80, 80);
    [button setTitle:@"点我" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    button.titleLabel.font = [UIFont systemFontOfSize:13.f];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 8.f;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)clickButton{
    [self doAnimation];
}
-(void)doAnimation{
    
    //判断是否正在转
    if (_isAnimation) {
        return;
    }
    _isAnimation = YES;
    
    //控制概率[0,80)
    NSInteger lotteryPro = arc4random()%95;
    NSLog(@"lotteryPro======%ld",lotteryPro);
    //设置转圈的圈数
    CGFloat starAngle = 35.5;
    NSInteger circleNum = 5;
    if (lotteryPro <= 5) {
        _circleAngle = starAngle;
    }else if (lotteryPro <= 15){
        _circleAngle = starAngle*2;
    }else if (lotteryPro <= 25){
        _circleAngle = starAngle*3;
    }else if (lotteryPro <= 35){
        _circleAngle = starAngle*4;
    }else if (lotteryPro <= 45){
        _circleAngle = starAngle*5;
    }else if (lotteryPro <= 55){
        _circleAngle = starAngle*6;
    }else if (lotteryPro <= 65){
        _circleAngle = starAngle*7;
    }else if (lotteryPro <= 75){
        _circleAngle = starAngle*8;
    }else if (lotteryPro <= 85){
        _circleAngle = starAngle*9;
    }else if (lotteryPro <= 95){
        _circleAngle = starAngle*10;
    }
    
    CGFloat perAngle = M_PI/180.0;
    NSLog(@"turnAngle = %ld",(long)_circleAngle);
    CABasicAnimation *rotaionAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotaionAnimation.toValue = [NSNumber numberWithFloat:_circleAngle * perAngle + 360 * perAngle * circleNum];
    rotaionAnimation.duration = 3.0f;
    rotaionAnimation.cumulative = YES;
    rotaionAnimation.delegate = self;
    //由快变慢
    rotaionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotaionAnimation.fillMode=kCAFillModeForwards;
    rotaionAnimation.removedOnCompletion = NO;
    [self.rotateImg.layer addAnimation:rotaionAnimation forKey:@"rotationAnimation"];
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    _isAnimation = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
