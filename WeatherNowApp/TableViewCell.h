//
//  TableViewCell.h
//  WeatherNowApp
//
//  Created by apple on 30/08/16.
//  Copyright © 2016 felix-its. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *datelbl;
@property (weak, nonatomic) IBOutlet UILabel *weatherlbl;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end
