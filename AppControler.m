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

    int x = 180; //possition x
    int y = 70; //possition y
    
    int width = 20;
    int height = 20;
    
    int dimentionx=9;
    int dimentiony=9;
    
    bombs_amount=0;
    
    btn=[[NSMutableArray alloc] init];
    
    bombs = [[NSMutableDictionary alloc] init];
    
    for (int k=0; k<dimentionx; k++) {
        for(int j=0; j<dimentiony;j++){
         
    NSButton *myButton = [[NSButton alloc] initWithFrame:NSMakeRect(x+k*19, y+j*17, width, height)];
    
    [myButton setTitle: @""];
    
    [myButton setButtonType:NSOnOffButton]; //Set what type button You want
    [myButton setBezelStyle:NSSmallSquareBezelStyle]; //Set what style You want

    [[myButton cell] setControlSize:NSSmallControlSize];

//            [myButton setTextColor:[CIColor ] forState: ];
            
    [myButton setTarget:self];
          

    int val=(arc4random()%2);
            
            if(val>0) bombs_amount++;
            
    NSLog(@"k= %d; j= %d",k, j);
           
    int tg=[[NSString stringWithFormat:@"%d%d",k,j] integerValue];
            
    [myButton setTag:tg];

    NSLog(@"TAG=%d",tg);
    [myButton setIntValue:0];
    [myButton setAction:@selector(buttonPressed:)];

            [bombs setObject:[NSNumber numberWithInt:val] forKey:[NSNumber numberWithInt:tg]];
            // dictionary of "0"s&"1"s for keys as 11 12 40...
            [btn addObject:myButton];
            // array of pointers to buttons
            
    [[self.window1 contentView] addSubview: myButton];

        }
    }
    [counter setIntValue:bombs_amount];
}


- (IBAction)setFlagged:(id)sender {
    
    if(flag==FALSE){
        flag=true;
        [sender setTitle:@"Unflag"];
    }
    else
    {
        flag=false;
        [sender setTitle:@"Flag"];
    }
}

- (IBAction)butClick:(id)sender{

    [label setStringValue:@"Starting new game!"];
    [self awakeFromNib];
    
}

-(NSButton*)getButtonByIndex:(int)index{
    
    for (NSButton* a in btn) {
        
        if ([a tag]==index) {
            return a;
        }
        
    }
    // remove it !
    return btn[0];
}

-(BOOL)isEnd{

    // add bombs check..
    
    for(NSButton* but in btn){
        if([but intValue]<1) return false;
    }
    return  true;
}


-(int)getMinsByIndex:(int)xy{

    return [[bombs objectForKey:[NSNumber numberWithInt:xy]] integerValue];
    
}

-(void)CountEight:(int)bomb_ind:(NSMutableArray*)zer:(int)iteration
{
    
    int a=[[zer objectAtIndex:bomb_ind] integerValue];
    
    NSLog(@"FUNCTION=%i",a);
    
    int b=0;
    
    NSArray *nei=[NSArray arrayWithObjects:[NSNumber numberWithInt:-10], [NSNumber numberWithInt:-1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:10],[NSNumber numberWithInt:-11],[NSNumber numberWithInt:11],[NSNumber numberWithInt:-9],[NSNumber numberWithInt:9], nil];
    
    
    for (NSNumber *count in nei){
        
        if ([bombs objectForKey:[NSNumber numberWithInt:(a+[count integerValue])]]) {
            
            NSButton* butt=[self getButtonByIndex:[NSNumber numberWithInt:(a+[count integerValue])]];
            
            NSLog(@"String is=%@",[butt title]);
            
            if ([[[self getButtonByIndex:[NSNumber numberWithInt:(a+[count integerValue])]] title] isEqualToString:@""]) {
                
            // checking bombs in neighbourhood : 1 or 0;
            
            int temp=[[bombs objectForKey:[NSNumber numberWithInt:(a+[count integerValue])]] integerValue];
            
            b+=temp;
            
            if ((temp == 0) && (![zer containsObject:[NSNumber numberWithInt:(a+[count integerValue])]]))
            {
                [zer addObject:[NSNumber numberWithInt:(a+[count integerValue])]];
            }
            
            [[self getButtonByIndex:a] setIntValue:1];
            [[self getButtonByIndex:a] setEnabled:NO];
            [[self getButtonByIndex:a] setTitle:[NSString stringWithFormat:@"%i",b]];
        }
        }
    }
    
    bomb_ind++;
    
    if((bomb_ind<[zer count]) && (iteration > 0))
    {
        iteration--;
        [self CountEight:bomb_ind:zer:iteration];
    }
    else NSLog(@"Recursion completed");
    
}


- (void)mouseDown:(NSEvent *)theEvent {
    
    NSUInteger pressedButtonMask = [NSEvent pressedMouseButtons];
    BOOL leftMouseDown = ((pressedButtonMask & (1 << 0))) != 0;
    BOOL rightMouseDown = ((pressedButtonMask & (1 << 1))) != 0;
    if (leftMouseDown) { NSLog(@"left"); }
    if (rightMouseDown) { NSLog(@"right"); }
   // NSResp
}



-(void)buttonPressed:(id)sender {

   // [sender setIntValue:1];
    int iteration=100;
    NSMutableArray *zeros=[[NSMutableArray alloc]init];
    NSLog(@"%i",bombs_amount);
    NSLog(@"%@",[sender title]);
    if (flag){
        
        if([[sender title] isEqualToString:@""]) {
        
        bombs_amount--;
        [counter setIntValue:bombs_amount];
        [sender setTitle:@"X"];
        }
        
        [sender setIntValue:1];
        
        if([self isEnd]) {
            [label setStringValue:@"Congrats!!!"];
            
        }
    }
    else if ([self getMinsByIndex:[sender tag]]==1)
    {
        if([[sender title] isEqualToString:@"X"])
        {
            bombs_amount++;
            [counter setIntValue:bombs_amount];
            
        }
        for (NSButton* mybutton in btn) {
            [mybutton setTitle:[NSString stringWithFormat:@"%i",[self getMinsByIndex:[mybutton tag]]]];
            [mybutton setEnabled:NO];
            [mybutton setIntValue:1];
        }
        
        [sender setTitle:@"X"];
        [label setStringValue:@"Game over"];
        
        NSLog(@"Game over");
        
    } else // cell is NOT a BOMB
    {
        if([[sender title] isEqualToString:@"X"])
        {
            bombs_amount++;
            [counter setIntValue:bombs_amount];
            
        }
        [zeros addObject:[NSNumber numberWithInt:([sender tag])]];
        [self CountEight:0:zeros:iteration];
        
        if([self isEnd]) {
            [label setStringValue:@"Congrats!!!"];
            
        }
    }
    
}
    
@end
