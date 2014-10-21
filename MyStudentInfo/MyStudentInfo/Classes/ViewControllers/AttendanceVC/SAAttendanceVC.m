//
//  SAAttendanceVC.m
//  MyStudentInfo
//
//  Created by Macbook Air AES on 16/10/14.
//  Copyright (c) 2014 SCS. All rights reserved.
//

#import "SAAttendanceVC.h"
#import "XMLReader.h"

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
static const CGFloat dia = 230.0f;
static const CGRect kPieChartViewFrame = {{45.0f, 150.0f},{dia, dia}};
@interface SAAttendanceVC ()
<
PieChartViewDelegate,
PieChartViewDataSource
>
{
    UILabel *holeLabel;
    UILabel *valueLabel;
}

@end

@implementation SAAttendanceVC

#pragma mark - View Controller's events

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
    recordResults = FALSE;
	
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<Att xmlns=\"http://tempuri.org/\">"
                             "<u>%@</u>"
                             "</Att>"
                             "</soap:Body>"
                             "</soap:Envelope>",                  [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"]
                             ];
    
//	NSLog(@"Soap Message = %@",soapMessage);
	
//    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"] );
	NSURL *url = [NSURL URLWithString:@"http://aesics.ac.in/WebService.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://tempuri.org/Att" forHTTPHeaderField:@"SOAPAction"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [NSMutableData data] ;
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
	
	

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


#pragma mark - XML Parser events

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"ERROR with theConenction");
	//[connection release];
    //	[webData release];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"DONE. Received Bytes: %lu", (unsigned long)[webData length]);
	NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    
//	NSLog(@"%@",theXML);
    //	[theXML release];
    
    //For Direct get Dictionary From Classes
    
        NSError *error;
        NSDictionary *dictResponce = [XMLReader dictionaryForXMLString:theXML error:&error];
      //  NSLog(@"Dictionary = %@",dictResponce);
      //  NSLog(@"%@", [[[[[[dictResponce objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"AttResponse"] objectForKey:@"AttResult"] objectForKey:@"string"] objectForKey:@"text"]);
	_lbl_Attendance_Text.text =[[[[[[dictResponce objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"AttResponse"] objectForKey:@"AttResult"] objectForKey:@"string"] objectForKey:@"text"];
    attendanceVal = [[[[[_lbl_Attendance_Text.text componentsSeparatedByString:@":"] lastObject] stringByReplacingOccurrencesOfString:@"%" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] integerValue];
    [self loadPieChart];
}

-(void)loadPieChart
{
    pieChartView = [[PieChartView alloc] initWithFrame:kPieChartViewFrame];
    pieChartView.delegate = self;
    pieChartView.datasource = self;
    [self.view addSubview:pieChartView];
    
    UIView *vwSeperatorOnPie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 61)];
    [vwSeperatorOnPie setBackgroundColor:RGBA(50, 50, 50, 1)];
    [self.view addSubview:vwSeperatorOnPie];
    
    UILabel *lblPercentage = [[UILabel alloc] initWithFrame:CGRectMake(122, 240, 75, 50)];
    lblPercentage.text=[NSString stringWithFormat:@"%ld%%",(long)attendanceVal];
    lblPercentage.textColor=RGBA(0, 115, 0, 1.0);
    lblPercentage.font = [UIFont systemFontOfSize:30];
    lblPercentage.textAlignment = NSTextAlignmentCenter;
//    lblPercentage.backgroundColor =[UIColor blueColor];
    [self.view addSubview:lblPercentage];
    
    [pieChartView reloadData];
    
}

-(CGFloat)centerCircleRadius
{
    return 56.5;
}

-(int)numberOfSlicesInPieChartView:(PieChartView *)pieChartView
{
    return 2;
}

-(UIColor *)pieChartView:(PieChartView *)pieChartView colorForSliceAtIndex:(NSUInteger)index
{
    if (index==0)
        return RGBA(0, 115, 0, 1.0);
    else
        return [UIColor redColor];
}

-(double)pieChartView:(PieChartView *)pieChartView valueForSliceAtIndex:(NSUInteger)index
{
    
    if (index==0)
        return attendanceVal;
    else
        return (100-attendanceVal);
}


@end
