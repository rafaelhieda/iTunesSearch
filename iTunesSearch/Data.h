//
//  Data.h
//  iTunesSearch
//
//  Created by Rafael  Hieda on 11/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *price;
@property(nonatomic, strong) NSString *mediaType;
@property(nonatomic, strong) NSString *currency;
@property(nonatomic, strong) NSString *country;

@end
