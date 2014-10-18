//
//  SAAttendanceVC.m
//  MyStudentInfo
//
//  Created by Macbook Air AES on 16/10/14.
//  Copyright (c) 2014 SCS. All rights reserved.
//

#import "SAAttendanceVC.h"
#import "XMLReader.h"

@interface SAAttendanceVC ()

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
}


@end
