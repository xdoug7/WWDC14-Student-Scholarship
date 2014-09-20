//
//  BaseStoryCell.h
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 06/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface BaseStoryCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *cardBackgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cloudImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;

@end
