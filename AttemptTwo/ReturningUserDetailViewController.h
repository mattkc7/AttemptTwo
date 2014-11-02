//
//  ReturningUserDetailViewController.h
//  AttemptTwo
//
//  Created by mchan2 on 11/1/14.
//  Copyright (c) 2014 MatthewChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReturningUserDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
