//
//  DetailViewController.m
//  iTunesSearch
//
//  Created by Rafael  Hieda on 13/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_artistLabel setText: [data name]];
    
    [_mediaLabel setText:[data mediaType]];
    
    [_countryLabel setText: [data country]];
    
    [_priceLabel setText: [NSString stringWithFormat: @"%@: %@", [data currency], [data price]]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
