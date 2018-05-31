//
//  CollectionViewController.m
//  iOSProficiencyExercise
//
//  Created by Arnel Perez on 28/05/2018.
//  Copyright © 2018 Arnel Perez. All rights reserved.
//

#import "CollectionViewController.h"
#import "DetailsCollectionViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController
@synthesize arrayRows, collectionViewMain;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
    
    [collectionViewMain setDataSource:self];
    [collectionViewMain setDelegate:self];
    
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout *)self.collectionViewMain.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0); //top 20, left, bottom 20, right
    
    HUB = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUB];
    [HUB showWhileExecuting:@selector(callWebserviceURL) onTarget:self withObject:nil animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) callWebserviceURL{
    NSError * error = nil;
    NSString *jsonString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"] encoding:NSASCIIStringEncoding error:&error];
    
    if (!error) {
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSString *responseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"responseData: %@",responseData);
        
        NSMutableDictionary *dictData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        arrayRows = [dictData objectForKey:@"rows"];
        NSString *strTitle = [dictData objectForKey:@"title"];
        self.title = strTitle;
    
        [self.collectionViewMain reloadData];
    }
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
    
    NSMutableDictionary *dictDetails = [arrayRows objectAtIndex:indexPath.row];
    NSString *title = [dictDetails objectForKey:@"title"];
    NSString *description = [dictDetails objectForKey:@"description"];
    
    NSString *imageHref = [dictDetails objectForKey:@"imageHref"];
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
                                        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height - 50)];
                                       
                                       imgView.image = [UIImage imageWithData:data];
                                       [cell.contentView addSubview:imgView];
                                   }
                               }];
    }
    else{
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height - 50)];
        imgView.image = nil;
        [cell.contentView addSubview:imgView];
    }

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.contentView.frame.size.height - 50, cell.contentView.frame.size.width, 50)];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    if ((id)title != [NSNull null]){
        label.text = title;
    }
    else{
        label.text = @"";
    }
    
    [cell.contentView addSubview:label];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dictDetails = [arrayRows objectAtIndex:indexPath.row];
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailsCollectionViewController *controller = (DetailsCollectionViewController *)[storyboard instantiateViewControllerWithIdentifier:@"DetailsCollectionViewController"];
    controller.dictData = dictDetails;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController pushViewController:controller animated:YES];
}


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (IBAction)btnRefresh:(id)sender {
    HUB = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUB];
    [HUB showWhileExecuting:@selector(callWebserviceURL) onTarget:self withObject:nil animated:YES];

    [collectionViewMain reloadData];
}
@end
