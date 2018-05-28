//
//  ViewController.m
//  iOSProficiencyExercise
//
//  Created by Arnel Perez on 28/05/2018.
//  Copyright © 2018 Arnel Perez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
        
        NSMutableArray *arrayRows = [dictData objectForKey:@"rows"];
        NSString *strTitle = [dictData objectForKey:@"title"];
        self.title = strTitle;
    }
}

@end
