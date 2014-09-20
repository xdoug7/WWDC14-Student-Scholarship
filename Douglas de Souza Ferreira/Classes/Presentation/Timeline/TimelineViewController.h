//
//  TimelineViewController.h
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 05/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseStoryViewController.h"

@interface TimelineViewController : UIViewController <StoryDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
