//
//  SAHomeVC.m
//  MyStudentInfo
//
//  Created by indianic on 15/10/14.
//  Copyright (c) 2014 SCS. All rights reserved.
//

#import "SAHomeVC.h"

@interface SAHomeVC ()

@end

@implementation SAHomeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.navigationController.navigationBarHidden=NO;
        self.navigationItem.hidesBackButton=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn_settings_touched:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Settings"
                                                             delegate:self
                                                    cancelButtonTitle:@"Logout"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    // Programatically add Other button titles if they exist.
    
    //[actionSheet addButtonWithTitle:@"Static button"];
    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    
    [actionSheet showInView:self.view.window];
    
   

    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
       switch (buttonIndex) {
        case 0: // Dosomething
               [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"UserName"];
               [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"AutoLoaginWithName"];
               [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Logout"];
               [[NSUserDefaults standardUserDefaults] synchronize];
               [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
            break;
    default:
            break;
    }
}
@end
