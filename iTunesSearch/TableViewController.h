//
//  ViewController.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UINavigationBarDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)searchButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;
- (IBAction) segControlClicked:(id)sender;
@end

