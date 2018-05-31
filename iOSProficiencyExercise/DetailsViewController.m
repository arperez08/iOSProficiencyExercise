//
//  DetailsViewController.m
//  iOSProficiencyExercise
//
//  Created by Arnel Perez on 31/05/2018.
//  Copyright © 2018 Arnel Perez. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController
@synthesize lblDescription, imgImagebox, dictData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *title = [dictData objectForKey:@"title"];
    NSString *description = [dictData objectForKey:@"description"];
    
    self.title = title;
    lblDescription.text = description;
    
    NSString *imageHref = [dictData objectForKey:@"imageHref"];
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
                                       imgImagebox.image = [UIImage imageWithData:data];
                                   }
                               }];
    }
    else{
        imgImagebox.image = nil;
    }
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
