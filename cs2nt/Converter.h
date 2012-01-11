//
//  Converter.h
//  cs2nt
//
//  Created by Krzysztof Wicher on 06/01/2012.
//  Copyright (c) 2012 MiK. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Converter : NSObject{
    NSString *seq;
    NSString *type;
    NSString *output;
    IBOutlet NSTextView *inputSeq;
    IBOutlet NSTextView *outputSeq;
    IBOutlet NSImageCell *well;
    NSButton *myButt;

}
-(id)init;
- (IBAction)convert:(id)sender;
- (NSString *)convert2nt:(NSString *)seqIn;
- (NSString *)convert2cs:(NSString *)seqIn;
- (IBAction)clearIn:(id)sender;
- (IBAction)clearOut:(id)sender;
- (IBAction)swapConvertion:(id)sender;
- (BOOL) rightFormat:(NSString*) testSeq;
- (void)alert;
@property (nonatomic,retain) IBOutlet NSButton *myButt;

@end
