//
//  SAResultVC.h
//  MyStudentInfo
//
//  Created by Macbook Air AES on 16/10/14.
//  Copyright (c) 2014 SCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAResultVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableData *webData;
	NSMutableString *soapResults;
	NSXMLParser *xmlParser;
	BOOL *recordResults;
    NSMutableArray *arSemesterResult ;
    
}
@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;

@property (weak, nonatomic) IBOutlet UITableView *tbl_view;



@end
