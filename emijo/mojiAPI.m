//
//  mojiAPI.m
//  emijo
//
//  Created by karamvir singh on 22/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import "mojiAPI.h"

@implementation mojiAPI

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark - Request For User Registration

+(NSMutableDictionary *)requestForUpdateUserPic:(NSData *)__imageData uid:(NSString *)__uid
{
    
    //NSLog(@"__uid == %@",__uid);
    
    
    NSString *reqURL = [NSString stringWithFormat:@"http://192.232.214.244/~avanttec/animoji/index.php/json?a=updateUserPicAction&uid=%@",__uid];
    
	NSString *urlStr = [reqURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
	//NSString *bodyString = [NSString stringWithFormat:@"jsonObject=%@",[__infoDict JSONRepresentation]];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    /*
     now lets create the body of the post
     */
    NSMutableData *bodyString = [NSMutableData data];
    //[bodyString appendData:[[NSString stringWithFormat:@"jsonObject=%@",[__infoDict JSONRepresentation]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [bodyString appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyString appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@_profile_img.jpg\"\r\n",__uid] dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyString appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyString appendData:[NSData dataWithData:__imageData]];
    [bodyString appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyString appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
	[request setHTTPBody:bodyString];
    
    //[request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
	[request setHTTPMethod:@"POST"];
    
	NSString *responseString = [self sendRequest:request];
	NSMutableDictionary *responseDict= [responseString JSONValue];
    //NSLog(@"%@",responseDict);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
    
    return dict;
}


#pragma mark -
#pragma mark - Send Request

+(NSString *)sendRequest:(NSMutableURLRequest *)request
{
	
	NSHTTPURLResponse *response;
	NSError *error;
	NSData *responseData;
	responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	if(responseData && [responseData length]) {
		NSString* aStr;
		aStr = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
		return aStr;
	}
	else {
		return @"No Record Found";
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
