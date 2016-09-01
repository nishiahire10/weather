//
//  TableViewController.h
//  WeatherNowApp
//
//  Created by apple on 26/08/16.
//  Copyright © 2016 felix-its. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController
@property (nonatomic,retain)NSMutableArray * weatherarray;
@property(nonatomic,retain)NSMutableData *mydata;
@property (nonatomic,retain)NSMutableArray *currentarray;
@property(nonatomic,retain)NSMutableArray *requestarray;

@property(nonatomic,retain)NSURL *url;
@end
