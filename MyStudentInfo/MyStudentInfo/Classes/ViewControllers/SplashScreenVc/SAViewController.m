//
//  SAViewController.m
//  MyStudentInfo
//
//  Created by indianic on 13/10/14.
//  Copyright (c) 2014 SCS. All rights reserved.
//

#import "SAViewController.h"
#import "SALoginVC.h"

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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Logout"]) {
//        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Logout"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//        [self performSelector:@selector(gotoLoginScreen) withObject:nil afterDelay:0.5];
//        SALoginVC *objSALoginVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SALoginVC"];
//        [self.navigationController pushViewController:objSALoginVC animated:NO];
//    }
}

-(void)gotoLoginScreen{
//    if ([[[[[NSUserDefaults standardUserDefaults] objectForKey:@"AutoLoaginWithName"] componentsSeparatedByString:@"_"] lastObject] boolValue]) {
//        [self performSegueWithIdentifier:@"SADirectHomeVC" sender:nil];
//    }else{
    
       [self performSegueWithIdentifier:@"SALoginVC" sender:nil];
        
//    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
