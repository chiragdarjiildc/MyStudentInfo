//
//  SAResultVC.m
//  MyStudentInfo
//
//  Created by Macbook Air AES on 16/10/14.
//  Copyright (c) 2014 SCS. All rights reserved.
//

#import "SAResultVC.h"
#import "XMLReader.h"

@interface SAResultVC ()

@end

NSMutableArray *arrResultFinal ;


@implementation SAResultVC

#pragma mark - View Controller's events

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    _tbl_view.delegate=self;
    _tbl_view.dataSource=self;
    
    [super viewWillAppear:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    recordResults = FALSE;
    arSemesterResult = [NSMutableArray arrayWithObjects:nil];
    
    arrResultFinal = [NSMutableArray  arrayWithObjects:nil];

    
    NSLog( @"%lu" ,(unsigned long)[arSemesterResult count]);
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<res xmlns=\"http://tempuri.org/\">"
                             "<u>%@</u>"
                             "<cls>-</cls>"
                             "</res>"
                             "</soap:Body>"
                             "</soap:Envelope>",                  [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"]
                             ];
    
    //	NSLog(@"Soap Message = %@",soapMessage);
	
    //    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"] );
	NSURL *url = [NSURL URLWithString:@"http://aesics.ac.in/WebService.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://tempuri.org/res" forHTTPHeaderField:@"SOAPAction"];
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
      NSLog(@"Dictionary = %@",dictResponce);
    NSMutableArray *tmparr = [NSMutableArray arrayWithObjects:[[[[[dictResponce objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"resResponse"] objectForKey:@"resResult"] objectForKey:@"string"], nil];
    
    [arSemesterResult  addObjectsFromArray:[[[[[dictResponce objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"resResponse"] objectForKey:@"resResult"] objectForKey:@"string"]];
    
       NSLog(@"%@",[[arSemesterResult objectAtIndex:0] objectForKey:@"text"]);
     NSLog(@"%@", [[[[[[[dictResponce objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"resResponse"] objectForKey:@"resResult"] objectForKey:@"string"] objectAtIndex:0] objectForKey:@"text" ]);
    
    for(int i=0;i< [arSemesterResult count];i++)
    {
        [arrResultFinal addObject:[[[[[[[dictResponce objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"resResponse"] objectForKey:@"resResult"] objectForKey:@"string"] objectAtIndex:i] objectForKey:@"text" ] ];
    }
    [self.tbl_view reloadData];
    
}

#pragma mark - Table View Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [arrResultFinal count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tbl_view dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //  NSLog(@"%@",indexPath);
    //  NSLog(@"%@",arLibraryResult);
    
    // UIImageView *IMGVIEW = [cell.contentView viewWithTag:1001];
    //  IMGVIEW.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",indexPath.row]];
    UILabel *lbl_date = [cell.contentView viewWithTag:1001];
   
    
    lbl_date.text = [NSString stringWithFormat:@"%@",[arrResultFinal objectAtIndex:indexPath.row] ]   ;
   
    
    // cell.textLabel.text =  [arLibraryResult objectAtIndex:indexPath.row];
    //  cell.textLabel.text = [NSString stringWithFormat:@"%ld-%@",(long)indexPath.row,[arLibraryResult objectAtIndex:indexPath.row] ]   ;
    
    return cell;
    
}


@end
