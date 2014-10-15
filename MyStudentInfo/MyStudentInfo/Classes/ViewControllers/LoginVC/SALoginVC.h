//
//  SALoginVC.h
//  MyStudentInfo
//
//  Created by indianic on 13/10/14.
//  Copyright (c) 2014 SCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SALoginVC : UIViewController<NSXMLParserDelegate>
{
    NSMutableData *webData;
	NSMutableString *soapResults;
	NSXMLParser *xmlParser;
	BOOL *recordResults;
    
}
@property (weak, nonatomic) IBOutlet UITextField *txt_username;
@property (weak, nonatomic) IBOutlet UITextField *txt_password;
- (IBAction)btn_login_touched:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbl_login_status;
@property (weak, nonatomic) IBOutlet UILabel *lbl_save_password;
@property (weak, nonatomic) IBOutlet UIButton *btn_save_password;
- (IBAction)btn_save_password_touched:(id)sender;

@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;

@end
