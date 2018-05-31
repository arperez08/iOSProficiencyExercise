//
//  ViewController.h
//  iOSProficiencyExercise
//
//  Created by Arnel Perez on 28/05/2018.
//  Copyright © 2018 Arnel Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    MBProgressHUD *HUB;
    NSMutableArray *arrayRows;
}
@property (strong, nonatomic)  NSMutableArray *arrayRows;
@end

