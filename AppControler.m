//
//  AppControler.m
//  Saper
//
//  Created by Pavlo Danchuk on 9/28/13.
//  Copyright (c) 2013 Pavlo Danchuk. All rights reserved.
//


#import "AppControler.h"


@implementation AppControler

- (void)awakeFromNib {
    [label setFont:[NSFont fontWithName:@"Courier" size:15]];
    [label setTextColor:[NSColor redColor]];
    [label setSelectable:YES];
   
    
    //====
    
    // Insert code here to initialize your application

    int x = 200; //possition x
    int y = 80; //possition y
    
    int width = 20;
    int height = 22;
    
    int dimentionx=5;
    int dimentiony=5;

    _btn=[[NSMutableArray alloc] init];
    
    _bombs = [[NSMutableDictionary alloc] init];
    
    for (int k=0; k<dimentionx; k++) {
        for(int j=0; j<dimentiony;j++){
         
    NSButton *myButton = [[NSButton alloc] initWithFrame:NSMakeRect(x+k*19, y+j*18, width, height)];
    
    [myButton setTitle: @""];
    
    [myButton setButtonType:NSOnOffButton]; //Set what type button You want
    [myButton setBezelStyle:NSSmallSquareBezelStyle]; //Set what style You want

    [[myButton cell] setControlSize:NSSmallControlSize];
    [myButton setTarget:self];
          
    int val=(arc4random()%2);
            
    NSLog(@"k= %d; j= %d",k, j);
           
    int tg=[[NSString stringWithFormat:@"%d%d",k,j] integerValue];
            
    [myButton setTag:tg];

    NSLog(@"TAG=%d",tg);
    [myButton setIntValue:0];
    [myButton setAction:@selector(buttonPressed:)];

            [_bombs setObject:[NSNumber numberWithInt:val] forKey:[NSNumber numberWithInt:tg]]; // dic of "0"s&"1"s for keys as 11 12 40...
            [_btn addObject:myButton];              // array of pointers to buttons
            
    [[self.window1 contentView] addSubview: myButton];

        }
        
    }
}


- (IBAction)butClick:(id)sender{

    [label setStringValue:@"Starting new game!"];
    
    
}

-(int)CountEight:(int)a{

    NSLog(@"FUNCTION=%d",a);
    
    int b=0;
    int temp=0;
    
    NSArray *nei=[NSArray arrayWithObjects:[NSNumber numberWithInt:-10], [NSNumber numberWithInt:-1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:10],[NSNumber numberWithInt:-11],[NSNumber numberWithInt:11],[NSNumber numberWithInt:-9],[NSNumber numberWithInt:9], nil];

    
    for (NSNumber *count in nei){
        
        if ([_bombs objectForKey:[NSNumber numberWithInt:(a+[count integerValue])]]) {
        
            temp=[[_bombs objectForKey:[NSNumber numberWithInt:(a+[count integerValue])]] integerValue];
         /*   if (temp == 0)
            {
                
                [self CountEight:([NSNumber numberWithInt:(a+[count integerValue])])];
            }*/
            b+=temp;
            
        }
    }
           NSLog(@"Here is %d mines around...",b);
    return b;
}

/*
-(void)setValuesForButtons:(NSDictionary *)

for (NSButton* a in _btn) {
    NSLog(@"%i",[a tag]);
    //        [label setIntValue:[a tag]];
    if ([a tag]==30) {
        [a setTitle:@"X"];
        
    }
    
}
 
 */
-(void)buttonPressed:(id)sender {


   // [label setIntValue:[sender tag]];
    [sender setIntValue:1];
    
    //int somekey=[[_bombs objectForKey:[NSNumber numberWithInt:[sender tag]]] integerValue];
    int bombs=0;
    if ([[_bombs objectForKey:[NSNumber numberWithInt:([sender tag])]] integerValue]==1)
    {
        [sender setTitle:@"X"];
        [label setStringValue:@"Game over"];
        
        // ... open all other fields
    
    } else //if ([[NSNumber numberWithInt:([sender tag])] integerValue]==0)
    {
        [sender setTitle:@""];
        bombs=[self CountEight:([[NSNumber numberWithInt:([sender tag])] integerValue])];
        if (bombs!=0)
        {
            [sender setTitle:[NSString stringWithFormat:@"%i",bombs]];
        }
    }
    
    [label setIntValue:[[_bombs objectForKey:[NSNumber numberWithInt:[sender tag]]] integerValue]];
    
}


@end
