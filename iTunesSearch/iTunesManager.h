//
//  iTunesManager.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iTunesManager : NSObject

/**
 * gets singleton object.
 * @return singleton
 */

@property NSMutableArray *podcastArray;

@property NSMutableArray *musicArray;

@property NSMutableArray *movieArray;

@property NSMutableArray *ebookArray;

@property NSMutableArray *dataArray;

+ (iTunesManager*)sharedInstance;

- (NSArray *)buscarMidias:(NSString *)termo;

-(NSDictionary *)results:(NSString *)termo;

-(NSDictionary *)results:(NSString *)termo media:(NSString *)media;

@end
