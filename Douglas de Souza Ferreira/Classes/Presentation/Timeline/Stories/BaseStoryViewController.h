//
//  BaseStoryViewController.h
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 12/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"

@protocol StoryDelegate <NSObject>

- (UIImage *)imageToBeBlurredWithSize:(CGSize)size;

@end

@interface BaseStoryViewController : UIViewController

#pragma mark - Properties
@property (weak, nonatomic) id <StoryDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *largeImageView;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;
@property (strong, nonatomic) Story *story;

#pragma mark - Actions
- (IBAction)dismissModal:(UIButton *)sender;

@end
