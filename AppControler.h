//
//  AppControler.h
//  Saper
//
//  Created by Pavlo Danchuk on 9/28/13.
//  Copyright (c) 2013 Pavlo Danchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppControler : NSWindowController{

    
@private
    IBOutlet NSTextField* label;
    NSMutableDictionary* bombs;
    NSMutableArray* btn;
    bool flag;
    IBOutlet NSTextField* counter;
    int bombs_amount;
};



@property (assign) IBOutlet NSWindow *window1;

- (IBAction)setFlagged:(id)sender;
- (IBAction)butClick:(id)sender;
- (void)CountEight:(int)ind:(NSMutableArray*)zer;
- (NSButton*)getButtonByIndex:(int)index;
- (void)mouseDown:(NSEvent *)theEvent;

@end
