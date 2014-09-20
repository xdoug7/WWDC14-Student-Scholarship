//
//  AnimationManager.m
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 12/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import "AnimationManager.h"

@implementation AnimationManager

+ (void)performAnimationWithType:(AnimationType)type onView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay {
	switch (type) {
		case AnimationTypeBounceLeft:
		{
			// Start
			view.transform = CGAffineTransformMakeTranslation(-300, 0);
			[UIView animateKeyframesWithDuration:duration / 4 delay:delay options:0 animations: ^{
			    // End
			    view.transform = CGAffineTransformMakeTranslation(-10, 0);
			} completion: ^(BOOL finished) {
			    [UIView animateKeyframesWithDuration:duration / 4 delay:0 options:0 animations: ^{
			        // End
			        view.transform = CGAffineTransformMakeTranslation(0, 0);
				} completion: ^(BOOL finished) {
			        [UIView animateKeyframesWithDuration:duration / 4 delay:0 options:0 animations: ^{
			            // End
			            view.transform = CGAffineTransformMakeTranslation(-2, 0);
					} completion: ^(BOOL finished) {
			            [UIView animateKeyframesWithDuration:duration / 4 delay:0 options:0 animations: ^{
			                // End
			                view.transform = CGAffineTransformMakeTranslation(0, 0);
						} completion: ^(BOOL finished) {
						}];
					}];
				}];
			}];
			break;
		}

		case AnimationTypeBounceRight:
		{
			// Start
			view.transform = CGAffineTransformMakeTranslation(300, 0);
			[UIView animateKeyframesWithDuration:duration / 4 delay:delay options:0 animations: ^{
			    // End
			    view.transform = CGAffineTransformMakeTranslation(-10, 0);
			} completion: ^(BOOL finished) {
			    [UIView animateKeyframesWithDuration:duration / 4 delay:0 options:0 animations: ^{
			        // End
			        view.transform = CGAffineTransformMakeTranslation(0, 0);
				} completion: ^(BOOL finished) {
			        [UIView animateKeyframesWithDuration:duration / 4 delay:0 options:0 animations: ^{
			            // End
			            view.transform = CGAffineTransformMakeTranslation(-2, 0);
					} completion: ^(BOOL finished) {
			            [UIView animateKeyframesWithDuration:duration / 4 delay:0 options:0 animations: ^{
			                // End
			                view.transform = CGAffineTransformMakeTranslation(0, 0);
						} completion: ^(BOOL finished) {
						}];
					}];
				}];
			}];
		}

		default:
			break;
	}
}

+ (UIMotionEffectGroup *)motionGroupForParallaxEffect {
	// Set vertical effect
	UIInterpolatingMotionEffect *verticalMotionEffect =
	    [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
	                                                    type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
	verticalMotionEffect.minimumRelativeValue = @(-50);
	verticalMotionEffect.maximumRelativeValue = @(50);

	// Set horizontal effect
	UIInterpolatingMotionEffect *horizontalMotionEffect =
	    [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
	                                                    type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
	horizontalMotionEffect.minimumRelativeValue = @(-50);
	horizontalMotionEffect.maximumRelativeValue = @(50);

	// Create group to combine both
	UIMotionEffectGroup *group = [UIMotionEffectGroup new];
	group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];

	return group;
}

@end
