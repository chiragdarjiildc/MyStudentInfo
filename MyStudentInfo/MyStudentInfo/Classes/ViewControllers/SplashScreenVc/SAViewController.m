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
//    [self performSelector:@selector(gotoLoginScreen) withObject:nil afterDelay:1.0];
    [self showother ];
    
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

- (void)showother{
    imgBack.alpha = 1.0;
    imgBack.alpha = 0.8;
    
    [UIView beginAnimations:@"ken" context:NULL];
    [UIView setAnimationDuration:2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDidStopSelector:@selector(RightToLeftSlide)];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(0.00);
    CGAffineTransform moveLeft = CGAffineTransformMakeTranslation(0.9,0.9);
    CGAffineTransform combo1 = CGAffineTransformConcat(rotate, moveLeft);
    
    CGAffineTransform zoomOut = CGAffineTransformMakeScale(1.5,1.5);
    CGAffineTransform transform = CGAffineTransformConcat(zoomOut, combo1);
    imgBack.transform = transform;
    [UIView commitAnimations];
}


- (void)showHideDidStop{
    
    [UIView beginAnimations:@"fade" context:NULL];
    [UIView setAnimationDuration:2];
    imgBack.alpha = 0.0;
    imgBack.alpha = 1.0;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(RightToLeftSlide)];
    [UIView commitAnimations];
    
//    imgBack.image = [backgroundImageQueue objectAtIndex:0];
//    imgBack.image = [backgroundImageQueue objectAtIndex:[backgroundImageQueue count] - 1];
//    [backgroundImageQueue insertObject:backgroundB.image atIndex:0];
//    [backgroundImageQueue removeLastObject];
}

-(void)RightToLeftSlide{
    [UIView beginAnimations:@"fade" context:NULL];
    [UIView setAnimationDuration:4];
    imgBack.alpha = 1.0;
    imgBack.frame=CGRectMake(-320, 0,imgBack.frame.size.width,imgBack.frame.size.height);
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(gotoLoginScreen)];
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
