//
//  BaseAnimation.m
//  TestAnimation
//
//  Created by geng lei on 15/6/17.
//  Copyright (c) 2015年 com.fengche.cn. All rights reserved.
//

#import "BaseAnimation.h"

@implementation BaseAnimation

#pragma mark - UIViewControllerAnimatedTransitioning

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
}
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return 1.0;
}
-(void)handlePinch:(UIPinchGestureRecognizer*)pinch{
    
}
@end
