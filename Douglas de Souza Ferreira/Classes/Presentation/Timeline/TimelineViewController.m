//
//  TimelineViewController.m
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 05/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import "TimelineViewController.h"
#import "StoriesBO.h"
#import "Story.h"
#import "BaseStoryCell.h"
#import "AnimationManager.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TimelineViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray *storiesArray;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
@end

@implementation TimelineViewController

#pragma mark - View's Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];

	// Initialize the Stories Business Object to get all the stories from database
	StoriesBO *storiesBO = [[StoriesBO alloc] init];
	self.storiesArray = [storiesBO storiesArrayFromDatabase];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	// Calculate the collectionview's bottom offset
	CGPoint bottomOffset = CGPointMake(self.collectionView.contentOffset.x,
	                                   self.collectionView.contentSize.height - self.collectionView.bounds.size.height);

	// As this is a timeline it makes more sense to start from the bottom up
	// So scroll the collection view to bottom
	[self.collectionView setContentOffset:bottomOffset
	                             animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	[segue.destinationViewController setStory:sender];
	[segue.destinationViewController setDelegate:self];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.storiesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	// Get current row
	NSInteger currentRow = indexPath.row;

	// The lines bellow are used to adjust image and labels position
	// Odd - The image will be on the right side and the labels on the left
	// Even - The image will be on the left side and the labels on the right

	// If currentRow mod 2 is equals 1 means that current index cell is odd
	BOOL isCellIndexOdd = currentRow % 2;

	NSString *cellIdentifier;
	AnimationType type;

	if (isCellIndexOdd) {
		cellIdentifier = @"StoryCellLeft";
		type = AnimationTypeBounceLeft;
	}
	else {
		cellIdentifier = @"StoryCellRight";
		type = AnimationTypeBounceRight;
	}

	// Create a reusable cell with static identifier at indexPath
	BaseStoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
	                                                                forIndexPath:indexPath];

	// Set the info button tag to current row number to make reference with storiesArray
	cell.infoButton.tag = currentRow;

	// On button touch tells to self respond with cellButtonPressed selector
	[cell.infoButton addTarget:self
	                    action:@selector(cellButtonPressed:)
	          forControlEvents:UIControlEventTouchUpInside];

	// Get Story object from storiesArray at index based on collectionview current row
	Story *story = self.storiesArray[currentRow];

	cell.iconImageView.image = [UIImage imageNamed:story.smallIconName];
	cell.titleLabel.text = story.title;

	[AnimationManager performAnimationWithType:type
	                                    onView:cell.cardBackgroundView
	                                  duration:0.7f
	                                     delay:0];

	return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	UICollectionReusableView *reusableview = nil;

	if (kind == UICollectionElementKindSectionHeader) {
		reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
		                                                  withReuseIdentifier:@"TimelineHeader"
		                                                         forIndexPath:indexPath];
	}
	else if (kind == UICollectionElementKindSectionFooter) {
		reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
		                                                  withReuseIdentifier:@"TimelineFooter"
		                                                         forIndexPath:indexPath];
	}

	// return view
	return reusableview;
}

#pragma mark - StoryDelegate

- (UIImage *)imageToBeBlurredWithSize:(CGSize)size {
	// Create an temporary view with the modal's rect to be center on screen
	UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(CGPointZero.x,
	                                                            CGPointZero.y,
	                                                            size.width,
	                                                            size.height)];
	// Center the view on self view center
	tempView.center = self.view.center;

	// Create a context to take a snapshot
	UIGraphicsBeginImageContext(self.view.frame.size);

	// Take the snapshot from screen
	[self.view drawViewHierarchyInRect:self.view.frame
	                afterScreenUpdates:YES];

	// Render the snapshot on an UIImage
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

	// Ends the context
	UIGraphicsEndImageContext();

	// Return the cropped snapshot to modal frame
	return [self imageWithImage:image cropInRect:tempView.frame];
}

#pragma mark - Util Methods

- (void)cellButtonPressed:(UIButton *)sender {
	// Get the selected story from button's tag
	Story *selectedStory = self.storiesArray[sender.tag];

	NSString *identifier;

	switch ([selectedStory.category integerValue]) {
		case StoryCategoryApps:
			identifier = @"showApps";
			break;

		case StoryCategoryBase:
			identifier = @"showBaseStory";
			break;

		case StoryCategoryMap:
		{
			// Set the identifier string to nil to prevent a segue
			identifier = nil;

			// Get the movie path in application bundle
			NSBundle *bundle = [NSBundle mainBundle];
			NSString *moviePath = [bundle pathForResource:@"WWDC Trip" ofType:@"mp4"];
			// Create and load movie player controller
			NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
			self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];

			// Create a notification to remove movie player view when
			// the video finish
			[[NSNotificationCenter defaultCenter] addObserver:self
			                                         selector:@selector(moviePlayBackDidFinish:)
			                                             name:MPMoviePlayerPlaybackDidFinishNotification
			                                           object:self.moviePlayer];

			// Set properties and autoplay
			self.moviePlayer.controlStyle = MPMovieControlStyleDefault;
			self.moviePlayer.shouldAutoplay = YES;
			[self.view addSubview:self.moviePlayer.view];
			[self.moviePlayer setFullscreen:YES animated:YES];

			break;
		}

		case StoryCategoryiBeacon:
			identifier = @"showIBeacon";
			break;

		case StoryCategoryArticle:
			identifier = @"showArticle";
			break;

		default:
			identifier = @"showBaseStory";
			break;
	}

	if (identifier) {
		[self performSegueWithIdentifier:identifier
		                          sender:selectedStory];
	}
}

- (void)moviePlayBackDidFinish:(NSNotification *)notification {
	MPMoviePlayerController *player = [notification object];
	[[NSNotificationCenter defaultCenter] removeObserver:self
	                                                name:MPMoviePlayerPlaybackDidFinishNotification
	                                              object:player];

	if ([player
	     respondsToSelector:@selector(setFullscreen:animated:)]) {
		[player.view removeFromSuperview];
	}
}

- (UIImage *)imageWithImage:(UIImage *)image cropInRect:(CGRect)rect {
	// Create a graphics context with frame size
	UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1);
	// Draw the cropped image to a new image refference
	[image drawAtPoint:(CGPoint) {-rect.origin.x, -rect.origin.y }];

	// Rendering the graphics context with the image
	UIImage *croppedImage = UIGraphicsGetImageFromCurrentImageContext();

	// Finish the graphics context
	UIGraphicsEndImageContext();

	return croppedImage;
}

@end
