//
//  AnimationManager.h
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 12/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
	AnimationTypeBounceLeft,
	AnimationTypeBounceRight
} AnimationType;

@interface AnimationManager : NSObject

+ (void)performAnimationWithType:(AnimationType)type onView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay;

+ (UIMotionEffectGroup *)motionGroupForParallaxEffect;

@end
