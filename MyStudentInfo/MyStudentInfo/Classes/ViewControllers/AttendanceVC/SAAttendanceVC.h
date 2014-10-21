//
//  SAAttendanceVC.h
//  MyStudentInfo
//
//  Created by Macbook Air AES on 16/10/14.
//  Copyright (c) 2014 SCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartView.h"

@interface SAAttendanceVC : UIViewController
{
    NSMutableData *webData;
	NSMutableString *soapResults;
	NSXMLParser *xmlParser;
	BOOL *recordResults;
    PieChartView *pieChartView;
    NSInteger attendanceVal;
    
}

@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Attendance_Text;

@end
