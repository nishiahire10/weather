//
//  weatherdetails.h
//  WeatherNowApp
//
//  Created by apple on 29/08/16.
//  Copyright © 2016 felix-its. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface weatherdetails : NSObject



@property (nonatomic,retain) NSString * date;
@property (nonatomic,retain)NSString * weather;
@property(nonatomic,retain)NSString *temperature;
@property(nonatomic,retain)NSString * urloficon;
@property(nonatomic,retain)NSData * image;
@property(nonatomic,retain)NSString *query;
@property(nonatomic,retain)NSString *value;



@end
