//
//  DetailViewController.h
//  iTunesSearch
//
//  Created by Rafael  Hieda on 13/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *mediaLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;

@property(strong, nonatomic) Data *data;

@end
