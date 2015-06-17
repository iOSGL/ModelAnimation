//
//  ModelAnimation.m
//  TestAnimation
//
//  Created by geng lei on 15/6/17.
//  Copyright (c) 2015年 com.fengche.cn. All rights reserved.
//

#import "ModelAnimation.h"

@implementation ModelAnimation{
    UIView * _corverView;
    NSArray * _constraints;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView * containerView = [transitionContext containerView];
    if (self.type == AnimationTypePresent) {
        UIView * modelView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        if (!_corverView) {
            _corverView = [[UIView alloc]initWithFrame:containerView.frame];
            _corverView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
            _corverView.alpha = 0.0;
            
        }else{
            _corverView.frame = containerView.frame;
        }
        [containerView addSubview:_corverView];
        
        modelView.translatesAutoresizingMaskIntoConstraints = NO;
        [containerView addSubview:modelView];
        NSDictionary * views = NSDictionaryOfVariableBindings(containerView,modelView);
        _constraints = [[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[modelView]-30-|" options:0 metrics:nil views:views] arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[modelView]-30-|" options:0 metrics:nil views:views]];
        [containerView addConstraints:_constraints];
        
        CGRect endFrame = modelView.frame;
        modelView.frame = CGRectMake(endFrame.origin.x, containerView.frame.size.height, endFrame.size.width, endFrame.size.height);
        [containerView bringSubviewToFront:modelView];
        
        //animation
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:0 animations:^{
            modelView.frame = endFrame;
            _corverView.alpha = 1.0;
        }completion:^(BOOL finshed){
            [transitionContext completeTransition:YES];
        }];
        
    }else if (self.type == AnimationTypeDismiss){
        UIView * modelView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
         
          UIView * snapshot = [modelView snapshotViewAfterScreenUpdates:NO];
        snapshot.frame = modelView.frame;
        [containerView addSubview:snapshot];
        [containerView bringSubviewToFront:snapshot];
        [modelView removeFromSuperview];
        
        CGRect originalFrame = snapshot.frame;
        snapshot.layer.anchorPoint = CGPointMake(0.0, 1.0);
        snapshot.frame = originalFrame;
        
        //动画
        [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:0 animations:^{
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.15 animations:^{
                // 90
                snapshot.transform = CGAffineTransformMakeRotation(M_PI*-1.5);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.15 relativeDuration:0.10 animations:^{
              //180
                snapshot.transform = CGAffineTransformMakeRotation(M_PI*1.0);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.2 animations:^{
                // 225
                snapshot.transform = CGAffineTransformMakeRotation(M_PI*1.3);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.45 relativeDuration:0.20 animations:^{
                snapshot.transform = CGAffineTransformMakeRotation(M_PI*0.8);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.65 relativeDuration:0.35 animations:^{
                CGAffineTransform shift = CGAffineTransformMakeTranslation(180.0, 0.0);
                CGAffineTransform rotate =CGAffineTransformMakeRotation(M_PI*0.4);
                snapshot.transform = CGAffineTransformConcat(shift, rotate);
                 _corverView.alpha = 0.0;
            }];
        }completion:^(BOOL finshed){
            [_corverView removeFromSuperview];
            [containerView removeConstraints:_constraints];
            [transitionContext completeTransition:YES];
        }];
        
                              
    }
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (self.type == AnimationTypePresent) {
        return 1.0;
    }else if (self.type == AnimationTypeDismiss){
        return 1.75;
    }else{
        return [super transitionDuration:transitionContext];
    }
}
@end
