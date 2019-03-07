//
//  ViewController.m
//  emijo
//
//  Created by 60Degree on 11/28/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    __appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    /*Form View*/
    _formview = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 300, 120)];
    _formview.backgroundColor = [UIColor orangeColor];
    _formview.layer.cornerRadius = 10;
    [self.view addSubview:_formview];
    
    /* Username */
    _userName = [[UITextField alloc] initWithFrame:CGRectMake(10, 20, 280, 25)];
    _userName.backgroundColor = [UIColor whiteColor];
    _userName.borderStyle = UITextBorderStyleRoundedRect;
    _userName.placeholder = NSLocalizedString(@"Username", nil);
    _userName.autocorrectionType = UITextAutocorrectionTypeNo;
    _userName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [_formview addSubview:_userName];
    
    
    /* Password */
    _password = [[UITextField alloc] initWithFrame:CGRectMake(10, 50, 280, 25)];
    _password.backgroundColor = [UIColor whiteColor];
    _password.borderStyle = UITextBorderStyleRoundedRect;
    _password.autocorrectionType = UITextAutocorrectionTypeNo;
    _password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _password.secureTextEntry = YES;
    _password.placeholder = NSLocalizedString(@"Password", nil);
    [_formview addSubview:_password];
        
    /* Submit Button */
    _submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 280, 25)];
    _submitBtn.backgroundColor = [UIColor blackColor];
    _submitBtn.layer.cornerRadius = 10;
    [_submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(submitForm) forControlEvents:UIControlEventTouchUpInside];
    [_formview addSubview:_submitBtn];
}

-(void) submitForm {

    bool valid = [self validateForm];
    NSLog(@"%d",valid);
 
    if(valid==YES) {
        [_submitBtn setTitle:@"Loading..." forState:UIControlStateNormal];
        /* Post Request*/
        NSString *serverUrl = @"http://60degreedeveloper.info/animoji/json";
        NSString *bodyData = [NSString stringWithFormat: @"a=loginAction&username=%@&password=%@", _userName.text, _password.text];
        
        NSLog(@"URl: %@",bodyData);
        NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverUrl]];
        
        // Set the request's content type to application/x-www-form-urlencoded
        [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        // Designate the request a POST request and specify its body data
        [postRequest setHTTPMethod:@"POST"];
        [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
        
        receivedData = [NSMutableData dataWithCapacity: 0];
        
        theConnection=[[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
        if (!theConnection) {
            receivedData = nil;
        }
    } else {
        
    }
}

-(BOOL)validateForm{
    NSString *errorMessage = nil;
    UITextField *errorField;

    if(!_userName.text || [_userName.text isEqualToString:@""])
    {
        errorMessage = @"Please enter username";
        errorField = _userName;
    }
    else if(!_password.text || [_password.text isEqualToString:@""])
    {
        errorMessage = @"Please enter password";
        errorField = _password;
    }
    
    if (errorMessage) {
        [self alert:errorMessage withObject:@"Failed"];
        return NO;
    }else{
        return YES;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}


- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    
    theConnection = nil;
    receivedData = nil;

    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:receivedData
                          options:kNilOptions
                          error:&error];
    
    NSLog(@"Response: \n%@", json);
    NSString *success = [NSString stringWithFormat:@"%@", [json objectForKey:@"success"]];
   
    [self alert:success withObject:@"Resposne"];
    
    if([success isEqualToString:@"true"]) {
        [_password setHidden:YES];
        [_userName setHidden:YES];
        [_submitBtn setHidden:YES];
        UILabel  *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 200, 150)];
        lbl.text = @"Successfully logged In \n %@";
        lbl.backgroundColor = [UIColor clearColor];
        lbl.textColor = [UIColor blackColor];
        [_formview addSubview:lbl];
    } else {
        [_submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    }
    theConnection = nil;
    receivedData = nil;
}



/* Add Emijo Page*/

/* Alert Box*/
-(void) alert: (NSString *) msg withObject:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
