//
//  DetailsViewController.h
//  iOSProficiencyExercise
//
//  Created by Arnel Perez on 31/05/2018.
//  Copyright © 2018 Arnel Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController
{
    NSMutableDictionary *dictData;
    IBOutlet UIImageView *imgImagebox;
    IBOutlet UILabel *lblDescription;
}
@property (strong, nonatomic) NSMutableDictionary *dictData;
@property (strong, nonatomic) IBOutlet UIImageView *imgImagebox;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;

@end
