//
//  StoriesBO.m
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 05/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import "StoriesBO.h"
#import "StoryDAO.h"

@implementation StoriesBO

- (NSArray *)storiesArrayFromDatabase {
	StoryDAO *storyDAO = [[StoryDAO alloc] init];
	return [storyDAO searchAllStories];
}

@end
