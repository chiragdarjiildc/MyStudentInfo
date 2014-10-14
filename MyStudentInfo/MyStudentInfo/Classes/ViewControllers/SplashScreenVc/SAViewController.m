//
//  SAViewController.m
//  MyStudentInfo
//
//  Created by indianic on 13/10/14.
//  Copyright (c) 2014 SCS. All rights reserved.
//

#import "SAViewController.h"

@interface SAViewController ()

@end

@implementation SAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    [self performSelector:@selector(gotoLoginScreen) withObject:nil afterDelay:5.0];
}

-(void)gotoLoginScreen{
    [self performSegueWithIdentifier:@"SALoginVC" sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
