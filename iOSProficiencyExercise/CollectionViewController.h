//
//  CollectionViewController.h
//  iOSProficiencyExercise
//
//  Created by Arnel Perez on 28/05/2018.
//  Copyright © 2018 Arnel Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    MBProgressHUD *HUB;
    NSMutableArray *arrayRows;
    IBOutlet UICollectionView *collectionViewMain;
}
@property (strong, nonatomic)  NSMutableArray *arrayRows;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionViewMain;

@end
