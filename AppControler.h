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
   
    
}


@property NSMutableDictionary* bombs;

@property (assign) IBOutlet NSWindow *window1;

- (IBAction)butClick:(id)sender;
- (int)CountEight:(int)a;

@end