//
//  SALoginVC.m
//  MyStudentInfo
//
//  Created by indianic on 13/10/14.
//  Copyright (c) 2014 SCS. All rights reserved.
//

#import "SALoginVC.h"
#import "XMLReader.h"

@interface SALoginVC ()

@end

@implementation SALoginVC
@synthesize txt_username,txt_password, webData, soapResults, xmlParser;

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
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=YES;
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

- (IBAction)btn_login_touched:(id)sender {
    recordResults = FALSE;
	
//	NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
//                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
//                             "<soap:Body>\n"
//                             "<lgn xmlns=\"http://tempuri.org/\">\n"
//                             "<u>%@</u>\n"
//                             "<u>%@</u>\n"
//                             "</lgn>\n"
//                             "</soap:Body>\n"
//                             "</soap:Envelope>", txt_username.text,txt_password.text
//                             ];
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<lgn xmlns=\"http://tempuri.org/\">"
                             "<unm>%@</unm>"
                             "<pwd>%@</pwd>"
                             "</lgn>"
                             "</soap:Body>"
                             "</soap:Envelope>", txt_username.text,txt_password.text
                             ];
    
	NSLog(@"Soap Message = %@",soapMessage);
	
	NSURL *url = [NSURL URLWithString:@"http://aesics.ac.in/WebService.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://tempuri.org/lgn" forHTTPHeaderField:@"SOAPAction"];
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
	
	[txt_password resignFirstResponder];
}

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
    
	NSLog(@"%@",theXML);
    //	[theXML release];
    
    //For Direct get Dictionary From Classes
    
    //    NSError *error;
    //    NSDictionary *dictResponce = [XMLReader dictionaryForXMLString:theXML error:&error];
    //    NSLog(@"Dictionary = %@",dictResponce);
    //    greeting.text = [[[[[[dictResponce objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"AttResponse"] objectForKey:@"AttResult"] objectForKey:@"string"] objectForKey:@"text"];
	
	if( xmlParser )
	{
        //		[xmlParser release];
	}
	NSError *readerError;
    NSDictionary *dictResponce = [XMLReader dictionaryForXMLData:webData error:&readerError];
    
    if (![[[[[[dictResponce objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"lgnResponse"] objectForKey:@"lgnResult"] objectForKey:@"string"] isKindOfClass:[NSArray class]]) {
        if ([[[[[[[dictResponce objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"lgnResponse"] objectForKey:@"lgnResult"] objectForKey:@"string"] objectForKey:@"text"] isEqualToString:@"X"]) {
            NSLog(@"LogIn Failed");
            _lbl_login_status.text =@"Wrong credentials.";
        }
    }else{
        NSLog(@"LogIn Success");
        _lbl_login_status.text =@"";
        [[NSUserDefaults standardUserDefaults] setObject:txt_username.text forKey:@"UserName"];
        
        
        
        if (_btn_save_password.selected) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@_%d",txt_username.text,YES] forKey:@"AutoLoaginWithName"];
            
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@_%d",txt_username.text,NO] forKey:@"AutoLoaginWithName"];
        }
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self performSegueWithIdentifier:@"SAHomeVC" sender:nil];
    }
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	if( [elementName isEqualToString:@"HelloResult"])
	{
		if(!soapResults)
		{
			soapResults = [[NSMutableString alloc] init];
		}
		recordResults = TRUE;
	}
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"String Result ==%@",string);
    txt_username.text = string;
	if( recordResults )
	{
		[soapResults appendString: string];
	}
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
	if( [elementName isEqualToString:@"HelloResult"])
	{
		recordResults = FALSE;
	    txt_username.text = soapResults;
        //		[soapResults release];
		soapResults = nil;
	}
}



- (IBAction)btn_save_password_touched:(id)sender {
    if (_btn_save_password.selected)
    {
        _btn_save_password.selected = NO;
        [_btn_save_password setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
    else
    {
        _btn_save_password.selected=YES;
        [_btn_save_password setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
    }
        
        
}
@end
