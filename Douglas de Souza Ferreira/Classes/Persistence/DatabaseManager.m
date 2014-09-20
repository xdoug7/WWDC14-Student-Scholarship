//
//  DatabaseManager.m
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 06/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import "DatabaseManager.h"

static DatabaseManager *sharedInstance = nil;

@implementation DatabaseManager

+ (id)sharedInstance {
	if (!sharedInstance) {
		sharedInstance = [[DatabaseManager alloc] init];
	}

	return sharedInstance;
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
	if (!_managedObjectContext) {
		NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
		if (coordinator != nil) {
			_managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
			[_managedObjectContext setPersistentStoreCoordinator:coordinator];
		}
	}

	return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
	if (!_managedObjectModel) {
		NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
		_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	}
	return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	if (!_persistentStoreCoordinator) {
		// Returns the URL to the application's Documents directory.
		NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
		NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"Model.sqlite"];

		NSError *error = nil;
		_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];

        NSFileManager *fileManager = [NSFileManager defaultManager];
        // If the expected store doesn't exist, copy the default store.
        if (![fileManager fileExistsAtPath:[storeURL path]]) {
            NSURL *defaultStoreURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"sqlite"];
            if (defaultStoreURL) {
                [fileManager copyItemAtURL:defaultStoreURL toURL:storeURL error:NULL];
            }
        }

		if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
		                                               configuration:nil
		                                                         URL:storeURL
		                                                     options:nil
		                                                       error:&error]) {
			NSLog(@"Error creating the store coordinator. Error %@, %@", error, [error userInfo]);
		}
	}


	return _persistentStoreCoordinator;
}

@end