//
//  DetailViewController.m
//  AttemptTwo
//
//  Created by mchan2 on 11/1/14.
//  Copyright (c) 2014 MatthewChan. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [confirmBtn setTitle:@"Swipe Card Now!" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(userPressedToSwipeCardButton) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.frame = CGRectMake(90, 190, 160, 60);
    [self.view addSubview:confirmBtn];
}

-(void)userPressedToSwipeCardButton
{
    NSLog(@"hi");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
