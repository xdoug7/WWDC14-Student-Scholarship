//
//  Story.h
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 13/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum : NSUInteger {
	StoryCategoryApps       = 1,
	StoryCategoryBase       = 2,
	StoryCategoryiBeacon    = 3,
	StoryCategoryMap        = 4,
	StoryCategoryArticle    = 5
} StoryCategory;

@interface Story : NSManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *smallIconName;
@property (nonatomic, retain) NSString *information;
@property (nonatomic, retain) NSString *largeIconName;
@property (nonatomic, retain) NSNumber *category;
@property (nonatomic, retain) NSString *title;

@end
