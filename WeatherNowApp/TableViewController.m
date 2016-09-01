//
//  TableViewController.m
//  WeatherNowApp
//
//  Created by apple on 26/08/16.
//  Copyright © 2016 felix-its. All rights reserved.
//

#import "TableViewController.h"
#import "weatherdetails.h"
#import "TableViewCell.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _weatherarray=[[NSMutableArray alloc]init];
    
    _currentarray = [[NSMutableArray alloc]init];
    
    _requestarray = [[NSMutableArray alloc]init];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    NSURLSessionConfiguration * congifuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession * session=[NSURLSession sessionWithConfiguration:congifuration];
    
    
     NSURL *url=[[NSBundle mainBundle]URLForResource:@"weather" withExtension:@"json"];
    
    NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:url];
    
    
    request.HTTPMethod=@"GET";
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary * dat=[dic objectForKey:@"data"];
        
        
        NSArray * currencondition=[dat objectForKey:@"current_condition"];
        
        
        for(NSDictionary * temp in currencondition)
        {
            
            weatherdetails * w2=[[weatherdetails alloc]init];
            
            w2.temperature=[temp objectForKey:@"temp_C"];
            
            NSArray * weather=[temp objectForKey:@"weatherDesc"];
            
            NSDictionary *dic = [weather objectAtIndex:0];
            
            w2.weather = [dic objectForKey:@"value"];
            
            NSArray *arr = [temp objectForKey:@"weatherIconUrl"];
            NSDictionary *dic1 = [arr objectAtIndex:0];
            w2.urloficon = [dic1 objectForKey:@"value"];
            
            self.url = [NSURL URLWithString:w2.urloficon];
            NSData *imgdata = [NSData dataWithContentsOfURL:_url];
            
            w2.image = [NSData dataWithData:imgdata];
            
            [_currentarray addObject:w2];
            
        }
        
        
        NSArray *request = [dat objectForKey:@"request"];
        
        for ( NSDictionary *temp in request)
        {
            weatherdetails *w3 = [[weatherdetails alloc]init];
            w3.query = [temp objectForKey:@"query"];
            w3.value = [temp objectForKey:@"type"];
            
            [_requestarray addObject:w3];
            
            
        }
        
        
        NSArray * weather=[dat objectForKey:@"weather"];
        
        for(NSDictionary * temp in weather)
        {
            weatherdetails * w1  =[[weatherdetails alloc]init];
            w1.date=[temp objectForKey:@"date"];
            
            NSArray *innerArray = [temp objectForKey:@"weatherDesc"];
            NSDictionary *innerDic = [innerArray objectAtIndex:0];
            w1.weather = [innerDic objectForKey:@"value"];
            
            
            
            NSArray * innarr=[temp objectForKey:@"weatherIconUrl"];
            NSDictionary * inndic=[innarr objectAtIndex:0];
         w1.urloficon = [inndic objectForKey:@"value"];
            
            self.url = [NSURL URLWithString:w1.urloficon];
        NSData *imgData = [NSData dataWithContentsOfURL:_url];
            
            w1.image=[NSData dataWithData:imgData];

           // NSLog(@"%@",[inndic objectForKey:@"value"]);
            
            [_weatherarray addObject:w1];
            
            
            
            
        }
        
        
        
        [self.tableView reloadData];
        
    }];
     [task resume];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    
    if (section == 0)
    {
        return _currentarray.count;
    }
    else if (section == 1)
    {
        return _requestarray.count;
    }
   else
    {
        return _weatherarray.count;
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //cell=[cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    switch (indexPath.section)
    {
        case 0:
        {
            weatherdetails  *temp =[_currentarray objectAtIndex:indexPath.row];
            cell.datelbl.text=temp.temperature;
            
            cell.weatherlbl.text=temp.weather;
            UIImage *image = [UIImage imageWithData:temp.image];
            cell.img.image = image;
            break;
        }
            
        case 1:
        {
            weatherdetails *temp = [_requestarray objectAtIndex:indexPath.row];
            cell.weatherlbl.text = temp.query;
            cell.datelbl.text = temp.value;
            break;
        }
       case 2:
        {
            // Configure the cell...
            weatherdetails *temp   =[_weatherarray objectAtIndex:indexPath.row];
            cell.datelbl.text = temp.date;
            cell.weatherlbl.text=temp.weather;
            
            //  NSData *imgData = [NSData dataWithContentsOfURL:_url];
            UIImage *imageLoad = [[UIImage alloc] initWithData:temp.image];
            cell.img.image = imageLoad;
            break;
        }
    }
    
//    if (indexPath.section==0)
//    {
//        weatherdetails  *temp =[_currentarray objectAtIndex:indexPath.row];
//        cell.datelbl.text=temp.temperature;
//        
//        cell.weatherlbl.text=temp.weather;
//        UIImage *image = [UIImage imageWithData:temp.image];
//        cell.img.image = image;
//
//        
//    }
//    else if (indexPath.section ==1)
//    {
//        weatherdetails *temp = [_requestarray objectAtIndex:indexPath.row];
//        cell.datelbl.text = temp.query;
//        cell.weatherlbl.text = temp.value;
//        
//    }
//    
//    else
//    {
//    // Configure the cell...
//   weatherdetails *temp   =[_weatherarray objectAtIndex:indexPath.row];
//    cell.datelbl.text = temp.date;
//    cell.weatherlbl.text=temp.weather;
//    
//  //  NSData *imgData = [NSData dataWithContentsOfURL:_url];
//    UIImage *imageLoad = [[UIImage alloc] initWithData:temp.image];
//    cell.img.image = imageLoad;
//        
//        
//        
//        
//    }
    
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
