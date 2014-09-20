//
//  BaseStoryCell.m
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 06/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import "BaseStoryCell.h"
#import "AnimationManager.h"

@implementation BaseStoryCell

- (void)drawRect:(CGRect)rect {
	self.cardBackgroundView.layer.cornerRadius = 10;
	self.cardBackgroundView.layer.shadowOffset = CGSizeZero;
	self.cardBackgroundView.layer.shadowRadius = 5;
	self.cardBackgroundView.layer.shadowOpacity = 0.3;

	CGFloat x = (CGFloat)(arc4random() % (int)self.cloudImageView.superview.bounds.size.width);
	CGFloat y = (CGFloat)(arc4random() % (int)self.cloudImageView.superview.bounds.size.height);
	self.cloudImageView.center = CGPointMake(x, y);

	// Add both effects to your view
	[self.cloudImageView addMotionEffect:[AnimationManager motionGroupForParallaxEffect]];

	[super drawRect:rect];
}

@end
