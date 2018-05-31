//
//  DetailsCollectionViewController.m
//  iOSProficiencyExercise
//
//  Created by Arnel Perez on 31/05/2018.
//  Copyright © 2018 Arnel Perez. All rights reserved.
//

#import "DetailsCollectionViewController.h"

@interface DetailsCollectionViewController ()

@end

@implementation DetailsCollectionViewController
@synthesize dictData, collectionViewMain, arrayRows;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;

    
    // Do any additional setup after loading the view.
    [collectionViewMain setDataSource:self];
    [collectionViewMain setDelegate:self];
    
    self.title = [dictData objectForKey:@"title"];
    
    arrayRows = [[NSMutableArray alloc] init];
    [arrayRows insertObject: [dictData objectForKey:@"imageHref"] atIndex:0];
    [arrayRows insertObject:[dictData objectForKey:@"description"] atIndex:1];
    
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

#pragma mark <UICollectionViewDataSource>
// Section for Item Count...
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [arrayRows count];
}

// CollectionViewCell Item Create...
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionViewMain dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *strDetails = [arrayRows objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        NSString *imageHref = strDetails;
        if ((id)imageHref != [NSNull null]){
            NSLog(@"photoURL: %@",imageHref);
            NSURL* url = [NSURL URLWithString:imageHref];
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
            request.HTTPMethod = @"GET";
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse * response,
                                                       NSData * data,
                                                       NSError * error) {
                                       if (!error){
                                           UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
                                           
                                           imgView.image = [UIImage imageWithData:data];
                                           [cell.contentView addSubview:imgView];
                                       }
                                   }];
        }
        else{
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
            imgView.image = nil;
            [cell.contentView addSubview:imgView];
        }
    }
    if (indexPath.row == 1) {
        NSString *description = strDetails;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        if ((id)description != [NSNull null]){
            label.text = description;
        }
        else{
            label.text = @"";
        }
        [cell.contentView addSubview:label];
    }
    return cell;
}


@end
