//
//  DatabaseManager.h
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 06/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DatabaseManager : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (id)sharedInstance;

@end
