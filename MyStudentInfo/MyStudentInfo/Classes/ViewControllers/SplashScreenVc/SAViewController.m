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
    self.navigationController.navigationBarHidden=YES;
	// Do any additional setup after loading the view, typically from a nib.
    [self performSelector:@selector(gotoLoginScreen) withObject:nil afterDelay:1.0];
    
}

-(void)gotoLoginScreen{
    if ([[[[[NSUserDefaults standardUserDefaults] objectForKey:@"AutoLoaginWithName"] componentsSeparatedByString:@"_"] lastObject] boolValue]) {
        [self performSegueWithIdentifier:@"HomeVc" sender:nil];
    }else{
       [self performSegueWithIdentifier:@"SALoginVC" sender:nil];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
