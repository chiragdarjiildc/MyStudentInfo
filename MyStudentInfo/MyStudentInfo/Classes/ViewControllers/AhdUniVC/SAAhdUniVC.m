//
//  SAAhdUniVC.m
//  MyStudentInfo
//
//  Created by Macbook Air AES on 16/10/14.
//  Copyright (c) 2014 SCS. All rights reserved.
//

#import "SAAhdUniVC.h"

@interface SAAhdUniVC ()

@end

@implementation SAAhdUniVC

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
//    
//    [_webview loadHTMLString:@""
//     "<html><p align=\"left\"><font face=\"Arial\" size=\"2\"><strong><font color=\"#000080\">School of Computer"
//     "Studies<font></strong><br>A.G.TEACHERS COLLEGE CAMPUS,<br>POST BOX NO. 4206<br>NAVRANGPURA,<br>AHMEDABAD - 380"
//     "009<br>GUJARAT - INDIA</font></p>"
//     "<p align=\"left\"><font face=\"Arial\" size=\"2\">Tel : (079) </font><font face=\"Arial\" size=\"2\"><font face="
//     "\"Arial\" size=\"2\">26402932, </font>26402987<br>Email : </font><a href=\"mailto:info@hlica.ac.in\"><font face=\"\"Arial\" size=\"2\">info.mca@ahduni.edu.in</font></a></p></html>"
//                     baseURL:nil];
//  
    
    [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.ahduni.edu.in" ]]];
    
   // [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@%@",@"http://m.forrent.com/search.php?address=",[[bookListing objectForKey:@"Data"] objectForKey:@"zip"],@"&beds=&baths=&price_to=0#{\"lat\":\"0\",\"lon\":\"0\",\"distance\":\"25\",\"seed\":\"1622727896\",\"is_sort_default\":\"1\",\"sort_by\":\"\",\"page\":\"1\",\"startIndex\":\"0\",\"address\":\"",[[bookListing objectForKey:@"Data"] objectForKey:@"zip"],@"\",\"beds\":\"\",\"baths\":\"\",\"price_to\":\"0\"}"]]]];
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
