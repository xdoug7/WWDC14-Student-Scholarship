//
//  StoryDAO.m
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 06/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import "StoryDAO.h"
#import "DatabaseManager.h"

@implementation StoryDAO

- (NSArray *)searchAllStories {
	// Get contexr from DatabaseManager
	NSManagedObjectContext *context = [[DatabaseManager sharedInstance] managedObjectContext];

	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Story"];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order"
	                                                               ascending:NO];
	[fetchRequest setSortDescriptors:@[sortDescriptor]];

	NSError *error;
	NSArray *fetchedResults = [context executeFetchRequest:fetchRequest error:&error];

	if (error) {
		NSLog(@"Error performing fetch. %@", [error localizedDescription]);
	}

	return fetchedResults;
}

@end
