//
//  XMLReader.h
//
//  Created by ind564 on 9/18/10.
//  Copyright 2010 ind564 . All rights reserved.
//

#import <Foundation/Foundation.h>

/**Perform conversions between XML string and NSDictionary*/
@interface XMLReader : NSObject<NSXMLParserDelegate>
{
    NSMutableArray *dictionaryStack;
    NSMutableString *textInProgress;
    NSError *errorPointer;
}
/**Gives NSDictionary for given NSData of xml string
 @param data
 @param errorPointer
 */
+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)errorPointer;

/**Gives NSDictionary for given xml string
 @param string
 @param errorPointer
 */
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)errorPointer;

/**Gives XML string for given NSDictionary and element
 @param dictionary
 @param startele
 */
+(NSString*)ConvertDictionarytoXML:(NSDictionary*)dictionary withStartElement:(NSString*)startele;
@end
