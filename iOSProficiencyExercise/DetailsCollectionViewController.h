//
//  DetailsCollectionViewController.h
//  iOSProficiencyExercise
//
//  Created by Arnel Perez on 31/05/2018.
//  Copyright © 2018 Arnel Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsCollectionViewController : UICollectionViewController  <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    NSMutableDictionary *dictData;
    NSMutableArray *arrayRows;
    IBOutlet UICollectionView *collectionViewMain;
}
@property (strong, nonatomic) NSMutableArray *arrayRows;
@property (strong, nonatomic) NSMutableDictionary *dictData;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionViewMain;

@end
