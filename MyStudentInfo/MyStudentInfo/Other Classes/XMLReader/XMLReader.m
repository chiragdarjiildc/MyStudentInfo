//
//  XMLReader.m
//
//  Created by ind564 on 9/18/10.
//  Copyright 2010 ind564 . All rights reserved.
//

#import "XMLReader.h"

NSString *const kXMLReaderTextNodeKey = @"text";

@interface XMLReader (Internal)

- (id)initWithError:(NSError **)error;
- (NSDictionary *)objectWithData:(NSData *)data;

@end


@implementation XMLReader

#pragma mark -
#pragma mark Public methods

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)error
{
//	NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//	NSLog(@"%@",str);
    XMLReader *reader = [[XMLReader alloc] initWithError:error];
    NSDictionary *rootDictionary = [reader objectWithData:data];
   // [reader release];
//	[str release];
    return rootDictionary;
}

+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)error
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [XMLReader dictionaryForXMLData:data error:error];
}

#pragma mark -
#pragma mark Parsing

- (id)initWithError:(NSError **)error
{
    if (self = [super init])
    {
     //   errorPointer = error;
    }
    return self;
}

- (void)dealloc
{
   // [dictionaryStack release];
    //[textInProgress release];
   // [super dealloc];
}

- (NSDictionary *)objectWithData:(NSData *)data
{
    // Clear out any old data
  //  [dictionaryStack release];
  //  [textInProgress release];
    
    dictionaryStack = [[NSMutableArray alloc] init];
    textInProgress = [[NSMutableString alloc] init];
    
    // Initialize the stack with a fresh dictionary
    [dictionaryStack addObject:[NSMutableDictionary dictionary]];
    
    // Parse the XML
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    BOOL success = [parser parse];
//	[parser release];
    // Return the stack's root dictionary on success
    if (success)
    {
        NSDictionary *resultDict = [dictionaryStack objectAtIndex:0];
        return resultDict;
    }

    return nil;
}

#pragma mark -
#pragma mark NSXMLParserDelegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    // Get the dictionary for the current level in the stack
    NSMutableDictionary *parentDict = [dictionaryStack lastObject];

    // Create the child dictionary for the new element, and initilaize it with the attributes
    NSMutableDictionary *childDict = [NSMutableDictionary dictionary];
    [childDict addEntriesFromDictionary:attributeDict];
    
    // If there's already an item for this key, it means we need to create an array
    id existingValue = [parentDict objectForKey:elementName];
    if (existingValue)
    {
        NSMutableArray *array = nil;
        if ([existingValue isKindOfClass:[NSMutableArray class]])
        {
            // The array exists, so use it
            array = (NSMutableArray *) existingValue;
        }
        else
        {
            // Create an array if it doesn't exist
            array = [NSMutableArray array];
            [array addObject:existingValue];

            // Replace the child dictionary with an array of children dictionaries
            [parentDict setObject:array forKey:elementName];
        }
        
        // Add the new child dictionary to the array
        [array addObject:childDict];
    }
    else
    {
        // No existing value, so update the dictionary
        [parentDict setObject:childDict forKey:elementName];
    }
    
    // Update the stack
    [dictionaryStack addObject:childDict];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // Update the parent dict with text info
    NSMutableDictionary *dictInProgress = [dictionaryStack lastObject];
    
    // Set the text property
    if ([textInProgress length] > 0)
    {
        [dictInProgress setObject:textInProgress forKey:kXMLReaderTextNodeKey];

        // Reset the text
  //      [textInProgress release];
        textInProgress = [[NSMutableString alloc] init];
    }

    
    // Pop the current dict
    [dictionaryStack removeLastObject];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // Build the text value
	if([string isEqualToString: @"2"])
		NSLog(@"%@",string);
    [textInProgress appendString:string];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    // Set the error pointer to the parser's error object
 //   *errorPointer = parseError;
}

#pragma mark DictionaryToXML
+(NSString*)ConvertDictionarytoXML:(NSDictionary*)dictionary withStartElement:(NSString*)startele
{
	NSMutableString *xml = [[NSMutableString alloc] initWithString:@""];
	NSArray *arr = [dictionary allKeys];
	[xml appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"];
	[xml appendString:[NSString stringWithFormat:@"<%@>",startele]];
	for(int i=0;i<[arr count];i++)
	{
		id nodeValue = [dictionary objectForKey:[arr objectAtIndex:i]];
		if([nodeValue isKindOfClass:[NSArray class]] )
		{
			if([nodeValue count]>0){
				for(int j=0;j<[nodeValue count];j++)
				{
					id value = [nodeValue objectAtIndex:j];
					[xml appendString:[NSString stringWithFormat:@"<%@>",[arr objectAtIndex:i]]];
					[xml appendString:[NSString stringWithFormat:@"%@",[value objectForKey:@"text"]]]; 
					[xml appendString:[NSString stringWithFormat:@"</%@>",[arr objectAtIndex:i]]];
				}
			}
		}
		else if([nodeValue isKindOfClass:[NSDictionary class]])
		{
			[xml appendString:[NSString stringWithFormat:@"<%@>",[arr objectAtIndex:i]]];
			if([[nodeValue objectForKey:@"Id"] isKindOfClass:[NSString class]])
				[xml appendString:[NSString stringWithFormat:@"%@",[nodeValue objectForKey:@"Id"]]]; 
			else
				[xml appendString:[NSString stringWithFormat:@"%@",[[nodeValue objectForKey:@"Id"] objectForKey:@"text"]]]; 
			[xml appendString:[NSString stringWithFormat:@"</%@>",[arr objectAtIndex:i]]];
		}

		else
		{
			if([nodeValue length]>0){
				[xml appendString:[NSString stringWithFormat:@"<%@>",[arr objectAtIndex:i]]];
				[xml appendString:[NSString stringWithFormat:@"%@",[dictionary objectForKey:[arr objectAtIndex:i]]]]; 
				[xml appendString:[NSString stringWithFormat:@"</%@>",[arr objectAtIndex:i]]];
			}
		}
	}
	
	[xml appendString:[NSString stringWithFormat:@"</%@>",startele]];
	NSString *finalxml=[xml stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
//	[xml release];
//	NSLog(@"%@",xml);
	return finalxml;
}
@end
