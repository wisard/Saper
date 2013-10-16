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

            [_bombs setObject:[NSNumber numberWithInt:val] forKey:[NSNumber numberWithInt:tg]];
            // dictionary of "0"s&"1"s for keys as 11 12 40...
            [_btn addObject:myButton];
            // array of pointers to buttons
            
    [[self.window1 contentView] addSubview: myButton];

        }
        
    }
}


- (IBAction)butClick:(id)sender{

    [label setStringValue:@"Starting new game!"];
    
    
}



-(NSButton*)getButtonByIndex:(int)index{
    
    for (NSButton* a in _btn) {
        
        if ([a tag]==index) {
            // int count=[self CountEight:([NSNumber numberWithInt:(index)])];
            //  [a setTitle:[NSString stringWithFormat:@"%i",count]];
            return a;
        }
        
    }
    
    // remove it !
    return _btn[0];
}

-(int)getMinsByIndex:(int)xy{

    return [[_bombs objectForKey:[NSNumber numberWithInt:xy]] integerValue];
    
}

-(void)CountEight:(int)ind:(NSMutableArray*)zer
{

    int a=[[zer objectAtIndex:ind] integerValue];
    
    NSLog(@"FUNCTION=%i",a);
    
    int b=0;
    
    NSArray *nei=[NSArray arrayWithObjects:[NSNumber numberWithInt:-10], [NSNumber numberWithInt:-1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:10],[NSNumber numberWithInt:-11],[NSNumber numberWithInt:11],[NSNumber numberWithInt:-9],[NSNumber numberWithInt:9], nil];
    
    
    for (NSNumber *count in nei){
        
        if ([_bombs objectForKey:[NSNumber numberWithInt:(a+[count integerValue])]]) {
        
            // checking bomb in neighbourhood : 1 or 0;
            
            int temp=[[_bombs objectForKey:[NSNumber numberWithInt:(a+[count integerValue])]] integerValue];
            
            b+=temp;
            
            if ((temp == 0) && (![zer containsObject:[NSNumber numberWithInt:(a+[count integerValue])]]))
            {
                
                [zer addObject:[NSNumber numberWithInt:(a+[count integerValue])]];
                
             //   [self setValuesForButtons:(a+[count integerValue])]; // --not bad
              //  [self CountEight:([NSNumber numberWithInt:(a+[count integerValue])])];
            }
            
            //for (NSButton* butt in _btn) {
               
            [[self getButtonByIndex:a] setIntValue:1];
            [[self getButtonByIndex:a] setTitle:[NSString stringWithFormat:@"%i",b]];
            

            
        }
           NSLog(@"Here is %d mines around...",b);
        
    }
    NSLog(@"%i,%d",ind,ind);
    ind++;
    
    NSInteger check=[[zer objectAtIndex:ind] integerValue];
                     
    if(check != NSNotFound) {
        
        [self CountEight:ind:zer];
        
    }
    else NSLog(@"Finaly!");
    
}


-(void)buttonPressed:(id)sender {


   // [label setIntValue:[sender tag]];
    [sender setIntValue:1];
    
    //int somekey=[[_bombs objectForKey:[NSNumber numberWithInt:[sender tag]]] integerValue];
    int bombs=0;
    
    NSMutableArray *zeros=[[NSMutableArray alloc]init];
    int ind=0;
    
    
    if ([self getMinsByIndex:[sender tag]]==1)
    {
        [sender setTitle:@"X"];
        [label setStringValue:@"Game over"];
        
        // ... to open all other fields
    
    } else // cell is NOT a BOMB
    {
        
        //bombs=
        [zeros addObject:[NSNumber numberWithInt:([sender tag])]];
        
        [self CountEight:0:zeros];
        
      /*  if (bombs!=0)
        {
            [sender setTitle:[NSString stringWithFormat:@"%i",bombs]];
        } else //if (bombs==0)
        {
            [sender setTitle:@""];
       
         //   [self setValuesForButtons:([count integerValue])];
       
        } */
    }
    
  //  [label setIntValue:[[_bombs objectForKey:[NSNumber numberWithInt:[sender tag]]] integerValue]];
    
}


@end
