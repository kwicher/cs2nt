//
//  Converter.m
//  cs2nt
//
//  Created by Krzysztof Wicher on 06/01/2012.
//  Copyright (c) 2012 MiK. All rights reserved.
//

#import "Converter.h"

@implementation Converter
@synthesize myButt;

-(id)init{
    type=@"cs2nt";

    return self;
}

- (NSString *)convert2cs:(NSString *)seqIn
{
    //DICT={"AA"=>"0", "CC"=>"0", "GG"=>"0", "TT"=>"0",
    //"AC"=>"1", "CA"=>"1", "TG"=>"1", "GT"=>"1",
    //"AG"=>"2", "GA"=>"2", "TC"=>"2", "CT"=>"2",
    //"AT"=>"3", "TA"=>"3", "GC"=>"3", "CG"=>"3"}
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:@"0" forKey:@"AA"];
    [dict setObject:@"0" forKey:@"CC"];
    [dict setObject:@"0" forKey:@"GG"];
    [dict setObject:@"0" forKey:@"TT"];
    [dict setObject:@"1" forKey:@"AC"];
    [dict setObject:@"1" forKey:@"CA"];
    [dict setObject:@"1" forKey:@"TG"];
    [dict setObject:@"1" forKey:@"GT"];
    [dict setObject:@"2" forKey:@"AG"];
    [dict setObject:@"2" forKey:@"GA"];
    [dict setObject:@"2" forKey:@"CT"];
    [dict setObject:@"2" forKey:@"TC"];
    [dict setObject:@"3" forKey:@"AT"];
    [dict setObject:@"3" forKey:@"TA"];
    [dict setObject:@"3" forKey:@"GC"];
    [dict setObject:@"3" forKey:@"CG"];
    NSString *first_base=[NSString stringWithFormat:@"%C",[seqIn characterAtIndex:0]];
    // NSLog(@"1:  %@",first_base);
    output=first_base;
    for(int i=1; i<[seqIn length]; i++){
    NSString *base = [NSString stringWithFormat:@"%C",[seqIn characterAtIndex:i]];    
        output=[output stringByAppendingString: [dict objectForKey:[first_base stringByAppendingString:base]]];
        first_base = base;
    }     
    return output;
}
- (NSString *)convert2nt:(NSString *)seqIn
{
    //DICT={"0"=>{"A"=>"A","C"=>"C","G"=>"G","T"=>"T"},
    //"1"=>{"A"=>"C","C"=>"A","G"=>"T","T"=>"G"},
    //"2"=>{"A"=>"G","G"=>"A","T"=>"C","C"=>"T"},
    //"3"=>{"A"=>"T","T"=>"A","G"=>"C","C"=>"G"}}
    
    NSMutableDictionary *dict1=[NSMutableDictionary dictionary];
    [dict1 setObject:@"A" forKey:@"A"];
    [dict1 setObject:@"C" forKey:@"C"];
    [dict1 setObject:@"G" forKey:@"G"];
    [dict1 setObject:@"T" forKey:@"T"];

    NSMutableDictionary *dict2=[NSMutableDictionary dictionary];
    [dict2 setObject:@"A" forKey:@"C"];
    [dict2 setObject:@"C" forKey:@"A"];
    [dict2 setObject:@"G" forKey:@"T"];
    [dict2 setObject:@"T" forKey:@"G"];
    
    NSMutableDictionary *dict3=[NSMutableDictionary dictionary];
    [dict3 setObject:@"A" forKey:@"G"];
    [dict3 setObject:@"G" forKey:@"A"];
    [dict3 setObject:@"T" forKey:@"C"];
    [dict3 setObject:@"C" forKey:@"T"];
    
    NSMutableDictionary *dict4=[NSMutableDictionary dictionary];
    [dict4 setObject:@"A" forKey:@"T"];
    [dict4 setObject:@"T" forKey:@"A"];
    [dict4 setObject:@"C" forKey:@"G"];
    [dict4 setObject:@"G" forKey:@"C"];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:dict1 forKey:@"0"];
    [dict setObject:dict2 forKey:@"1"];
    [dict setObject:dict3 forKey:@"2"];
    [dict setObject:dict4 forKey:@"3"];
    //NSLog(@"%@",seqIn);
    NSString *first_base=[NSString stringWithFormat:@"%C",[seqIn characterAtIndex:0]];
    //NSLog(@"%@",first_base);
    output=first_base;
    for(int i=1; i<[seqIn length]; i++){
        NSString *base = [NSString stringWithFormat:@"%C",[seqIn characterAtIndex:i]];
      //  NSLog(@":--- %@",base);
      //  NSLog(@"%@",[dict objectForKey:@"1"]);
        first_base=[[dict objectForKey:base] objectForKey:first_base];
      //  NSLog(@"after: %@",first_base);
        output=[output stringByAppendingString: first_base];
    }
    
    return output;
}
- (BOOL) rightFormat:(NSString*) testSeq
{
   // NSString *first_base=[NSString stringWithFormat:@"%C",[testSeq characterAtIndex:0]];
    NSPredicate *test;
        if(type==@"cs2nt") test=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[ACGT][0123]+"];
        else test=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[ACGT]+"];
    
    return [test evaluateWithObject:testSeq] ? TRUE : FALSE;


}
-(void)alert
{
    NSString *question = NSLocalizedString(@"PROBLEM", 
                                           @"UNA PROBLEMA");
    NSString *info = NSLocalizedString(@"Wrong formatting of the input sequence", 
                                       @"Correct the input sequence");
    NSString *cancelButton = NSLocalizedString(@"OK", 
                                               @"Cancel button title");
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:question];
    [alert setInformativeText:info];
    [alert addButtonWithTitle:cancelButton];
    [alert beginSheetModalForWindow:myButt.superview.window modalDelegate:self didEndSelector:nil contextInfo:nil];
    [alert release];
    alert = nil;
}
- (IBAction)convert:(id)sender
{
    seq=[inputSeq.string uppercaseString];
    if([self rightFormat:seq]){
     if (type==@"cs2nt") {        
        outputSeq.string=[self convert2nt:seq];   
     }
     else {
        outputSeq.string=[self convert2cs:seq];
        
     }
     }
    else [self alert];//NSLog(@"uPPS");
}
-(IBAction)swapConvertion:(id)sender
{
    if(type==@"nt2cs")
    {
        type=@"cs2nt";


        NSImage *imageg=[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"cs2nt" ofType:@"png"]];
         //imageg==nil? NSLog(@"upps"): NSLog(@"OK");
         [myButt setImage:imageg];
         //[myButt image]==nil? NSLog(@"upps"): NSLog(@"OK");
         [imageg release];    }
    else
    {
        type=@"nt2cs";
        //[myButt setImagePosition:NSImageOnly];
        //[myButt setTitle:type];

        NSImage *imageg=[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"nt2cs" ofType:@"png"]];
        //imageg==nil? NSLog(@"upps"): NSLog(@"OK");
        [myButt setImage:imageg];
        //[myButt image]==nil? NSLog(@"upps"): NSLog(@"OK");
        [imageg release];
    }
}
-(IBAction)clearIn:(id)sender
{
    inputSeq.string=@"";
}
-(IBAction)clearOut:(id)sender
{
    outputSeq.string=@"";
}
@end
