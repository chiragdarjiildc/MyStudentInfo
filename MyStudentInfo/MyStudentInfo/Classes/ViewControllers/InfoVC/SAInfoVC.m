//
//  SAInfoVC.m
//  MyStudentInfo
//
//  Created by Macbook Air AES on 16/10/14.
//  Copyright (c) 2014 SCS. All rights reserved.
//

#import "SAInfoVC.h"

@interface SAInfoVC ()

@end

@implementation SAInfoVC

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

      [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.aesics.ac.in/iosWeb.html" ]]];
    
//    [_webview loadHTMLString:@""
//     "<html><p align=\"left\"><font face=\"Arial\" size=\"3\"><strong><font color=\"#000080\">School of Computer"
//     "Studies<font></strong><br>A.G.TEACHERS COLLEGE CAMPUS,<br>POST BOX NO. 4206<br>NAVRANGPURA,<br>AHMEDABAD - 380"
//     "009<br>GUJARAT - INDIA</font></p>"
//     "<p align=\"left\"><font face=\"Arial\" size=\"2\">Tel : (079) </font><font face=\"Arial\" size=\"2\"><font face="
//     "\"Arial\" size=\"2\">26402932, </font>26402987<br>Email : </font><a href=\"mailto:info@hlica.ac.in\"><font face=\"\"Arial\" size=\"2\">info.mca@ahduni.edu.in</font></a></p></html>"
//                     baseURL:nil];

    
    
    // Do any additional setup after loading the view.
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

@end
