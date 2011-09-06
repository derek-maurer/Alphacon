#import "Headers.h"

#define PLIST @"/var/mobile/Library/Preferences/com.homeschooldev.alphacon.plist"

%class SpringBoard
%class SBIconController
%class SBDockIconListView
%class SBIconListView
%class SBFolderIcon
%class SBFolder

@interface Alphacon : NSObject {}
-(void)changeSwitcherIcons:(NSArray *)iconsArray forTweakState:(BOOL)state;
-(void)changeDockIconsForTweakState:(BOOL)state;
-(void)changeIconsInFolder:(id)folder forTweakState:(BOOL)state;
-(void)changeHomeScreenIconsForTweakState:(BOOL)state;
-(void)setIcons:(id)icon alpha:(float)alpha;
-(void)setLabels:(id)label alpha:(float)alpha;
@end

@implementation Alphacon

-(void)changeHomeScreenIconsForTweakState:(BOOL)state {

    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:PLIST] autorelease];
    SBIconController *sbController = [$SBIconController sharedInstance];
    NSMutableArray *iconsArray = MSHookIvar<NSMutableArray *>(sbController, "_rootIconLists");
    SBIconListView *list = [[[$SBIconListView alloc] init] autorelease];
    
    float sliderValue;
    int iconsArraySize = iconsArray.count;
    
    //Get slider value.
    if ([dict objectForKey:@"Slider"] != nil) {
            sliderValue = [[dict objectForKey:@"Slider"] floatValue];
    }
    else {
        sliderValue = 0.10;
    }
    
    if (state) {
    
        //*****************************HOME SCREEN ICONS****************************************
    
        //Set icons labels alpha...
        if ([dict objectForKey:@"HomeScreenLabels"] != nil && [dict objectForKey:@"Labels"] != nil) {
            if ([[dict objectForKey:@"HomeScreenLabels"] boolValue] && [[dict objectForKey:@"Labels"] boolValue]) {
                for (int i=0;i<iconsArraySize; i++) {
                    list = [iconsArray objectAtIndex:i];
                    [self setLabels:[list icons] alpha:0.0];
                }
            }
            else {
                if (![[dict objectForKey:@"HomeScreen"] boolValue]) {
                    for (int i=0;i<iconsArraySize; i++) {
                        list = [iconsArray objectAtIndex:i];
                        [self setLabels:[list icons] alpha:1.0];
                    }
                }
                else {
                    for (int i=0;i<iconsArraySize; i++) {
                        list = [iconsArray objectAtIndex:i];
                        [self setLabels:[list icons] alpha:sliderValue];
                    }
                }
            }
        }
        else {
            for (int i=0; i<iconsArraySize; i++) {
                list = [iconsArray objectAtIndex:i];
                [self setLabels:[list icons] alpha:1.0];
            }
        }
    
        //Set icons alpha
        if ([[dict objectForKey:@"HomeScreen"] boolValue]) {
            for (int i=0; i<iconsArraySize; i++) {
                list = [iconsArray objectAtIndex:i];
                [self setIcons:[list icons] alpha:sliderValue];
            }
        }
        else {
            for (int i=0; i<iconsArraySize; i++) {
                list = [iconsArray objectAtIndex:i];
                [self setIcons:[list icons] alpha:1.0];
            }
        }
    }
    else {
        
        //*****************************HOME SCREEN ICONS****************************************
        
        //Set icons labels alpha...
        for (int i=0;i<iconsArraySize; i++) {
            list = [iconsArray objectAtIndex:i];
            [self setLabels:[list icons] alpha:1.0];
        }
        
        //Set icons alpha
        for (int i=0; i<iconsArraySize; i++) {
            list = [iconsArray objectAtIndex:i];
            [self setIcons:[list icons] alpha:1.0];
        }
    }
}

-(void)changeDockIconsForTweakState:(BOOL)state {
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:PLIST] autorelease];
    SBIconController *sbController = [$SBIconController sharedInstance];
    SBDockIconListView *dock = MSHookIvar<SBDockIconListView *>(sbController, "_dock");
    
    float sliderValue;
    
    //Get slider value.
    if ([dict objectForKey:@"Slider"] != nil) {
        sliderValue = [[dict objectForKey:@"Slider"] floatValue];
    }
    else {
        sliderValue = 0.10;
    }
    
    //*****************************DOCK ICONS***********************************************
    
    if (state) {
        //Set dock labels alpha...
        if ([dict objectForKey:@"DockLabels"] != nil && [dict objectForKey:@"Labels"] != nil) {
            if ([[dict objectForKey:@"DockLabels"] boolValue] && [[dict objectForKey:@"Labels"] boolValue]) {
                [self setLabels:[dock icons] alpha:0.0];                
            }
            else {
                if (![[dict objectForKey:@"Dock"] boolValue]) {
                    [self setLabels:[dock icons] alpha:1.0];
                }
                else {
                    [self setLabels:[dock icons] alpha:sliderValue];
                }
            }
        }
        else {
            [self setLabels:[dock icons] alpha:1.0];
        }
    
        //Dock icons alpha...
        if ([[dict objectForKey:@"Dock"] boolValue]) {
            [self setIcons:[dock icons] alpha:sliderValue];
        }
        else {
            [self setIcons:[dock icons] alpha:1.0];
        }
    }
    else {
        //Set label alpha...
        [self setLabels:[dock icons] alpha:1.0];
        //Set icon alpha...
        [self setIcons:[dock icons] alpha:1.0];
    }
}

-(void)changeIconsInFolder:(id)folder forTweakState:(BOOL)state {
    NSArray *icons = [[folder allIcons] allObjects];
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:PLIST] autorelease];
    float sliderValue;
    
    //Set sliders value...
    if ([dict objectForKey:@"Slider"] != nil) {
        sliderValue = [[dict objectForKey:@"Slider"] floatValue];
    }
    else {
        sliderValue = 0.10;
    }
    
    if (state) {
        //Set labels alpha...
        if ([dict objectForKey:@"FoldersLabels"] != nil && [dict objectForKey:@"Labels"] != nil) {
            if ([[dict objectForKey:@"FoldersLabels"] boolValue] && [[dict objectForKey:@"Labels"] boolValue]) {
                [self setLabels:icons alpha:0.0];
            }
            else {
                if (![[dict objectForKey:@"Folders"] boolValue]) {
                    [self setLabels:icons alpha:1.0];
                }
                else {
                    [self setLabels:icons alpha:sliderValue];
                }
            }
        }
        else {
            [self setLabels:icons alpha:1.0];
        }
    
        //Set icons alpha...
        if ([[dict objectForKey:@"Folders"] boolValue]) {
            [self setIcons:icons alpha:sliderValue];
        }
        else {
            [self setIcons:icons alpha:1.0];
        }
    }
    else {
        //Tweak is disblaed, set icons to normal state...
        [self setLabels:icons alpha:1.0];
        [self setIcons:icons alpha:1.0];
    }
}

-(void)changeSwitcherIcons:(NSArray *)iconsArray forTweakState:(BOOL)state {
    
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:PLIST] autorelease];
    float sliderValue;
    
    //Set sliders value...
    if ([dict objectForKey:@"Slider"] != nil) {
        sliderValue = [[dict objectForKey:@"Slider"] floatValue];
    }
    else {
        sliderValue = 0.10;
    }
    
    if (state) {
        //*****************************SWITCHER ICONS********************************************
    
        //Set icons labels alpha...
        if ([dict objectForKey:@"SwitcherLabels"] != nil && [dict objectForKey:@"Labels"] != nil) {
            if ([[dict objectForKey:@"SwitcherLabels"] boolValue] && [[dict objectForKey:@"Labels"] boolValue]) {
                [self setLabels:iconsArray alpha:0.0];
            }
            else {
                if (![[dict objectForKey:@"Switcher"] boolValue]) {
                    [self setLabels:iconsArray alpha:1.0];
                }
                else {
                    [self setLabels:iconsArray alpha:sliderValue];
                }
            }
        }
        else {
            [self setLabels:iconsArray alpha:1.0];
        }
    
        //Set icons alpha...
        if ([[dict objectForKey:@"Switcher"] boolValue]) {
            [self setIcons:iconsArray alpha:sliderValue];
        }
        else {
            [self setIcons:iconsArray alpha:1.0];
        }
    }
    else {
        //Set icons labels alpha...
        [self setLabels:iconsArray alpha:1.0];
        
        //Set icons alpha...
        [self setIcons:iconsArray alpha:1.0];
    }
}

-(void)setIcons:(id)icons alpha:(float)alpha {
    NSArray *iconsArray = [[[NSArray alloc] init] autorelease];
    iconsArray = icons;
    
    int size = iconsArray.count;
    
    for (int i=0; i<size; i++) {
        [[iconsArray objectAtIndex:i] setIconImageAlpha:alpha];
    }
}

-(void)setLabels:(id)labels alpha:(float)alpha {
    NSArray *labelsArray = [[[NSArray alloc] init] autorelease];
    labelsArray = labels;
    
    int size = labelsArray.count;
    
    for (int i=0; i<size; i++) {
        [[labelsArray objectAtIndex:i] setIconLabelAlpha:alpha];
    }
}

@end

%hook SBUIController

-(void)fadeIconsForScatter:(BOOL)scatter duration:(double)duration startTime:(double)time { 
    
    %orig;
    
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:PLIST] autorelease];
    Alphacon *alphacon = [[[Alphacon alloc] init] autorelease];

    [[dict objectForKey:@"Enabled"] boolValue] ? [alphacon changeHomeScreenIconsForTweakState:YES] : [alphacon changeHomeScreenIconsForTweakState:NO];
}

%end

%hook SBIconController

-(void)setOpenFolder:(id)folder {
    %orig;
    
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:PLIST] autorelease];
    Alphacon *alphacon = [[[Alphacon alloc] init] autorelease];
   
    [[dict objectForKey:@"Enabled"] boolValue] ? [alphacon changeIconsInFolder:folder forTweakState:YES] : [alphacon changeIconsInFolder:folder forTweakState:NO];

}

-(void)_cleanupForClosingFolderAnimated:(BOOL)closingFolderAnimated {
      
    SBFolder *folder = MSHookIvar<SBFolder *>(self, "_closingFolder");
    %orig;
    if (folder != nil) {

        NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:PLIST] autorelease];
      
        float sliderValue;
    
        //Set sliders value...
        if ([dict objectForKey:@"Slider"] != nil) {
            sliderValue = [[dict objectForKey:@"Slider"] floatValue];
        }
        else {
            sliderValue = 0.10;
        }        
        SBFolderIcon *icon = MSHookIvar<SBFolderIcon *>(folder, "_icon");
        if ([dict objectForKey:@"HomeScreenLabels"] != nil && [dict objectForKey:@"Labels"] != nil) {
            if ([[dict objectForKey:@"HomeScreenLabels"] boolValue] && [[dict objectForKey:@"Labels"] boolValue]) {
                [icon setIconLabelAlpha:0.0];
            }
            else {
                [icon setIconLabelAlpha:sliderValue];
            }
        }
        else {
            [icon setIconLabelAlpha:1.0];
        }
    }
}

-(void)updateCurrentIconListIndexAndVisibility {
    %orig;
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:PLIST] autorelease];
    Alphacon *alphacon = [[[Alphacon alloc] init] autorelease];
    
    if (![self hasOpenFolder]) {
        if ([[dict objectForKey:@"Enabled"] boolValue]) {
            [alphacon changeHomeScreenIconsForTweakState:YES];
        }
        else {
            [alphacon changeHomeScreenIconsForTweakState:NO];
        }
    }
    else {
        SBFolder *folder = MSHookIvar<SBFolder *>(self, "_openFolder");
        if (folder != nil) {
            if ([dict objectForKey:@"Enabled"] != nil && [[dict objectForKey:@"Enabled"] boolValue]) {
                [alphacon changeIconsInFolder:folder forTweakState:YES];
            }
        }
    }
}

-(void)showDock:(BOOL)dock startTime:(double)time duration:(double)duration {
    %orig;
    
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:PLIST] autorelease];
    Alphacon *alphacon = [[[Alphacon alloc] init] autorelease];
    
    [[dict objectForKey:@"Enabled"] boolValue] ? [alphacon changeDockIconsForTweakState:YES] : [alphacon changeDockIconsForTweakState:NO];
}

%end

%hook SBAppSwitcherBarView

-(void)viewWillAppear {
    
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:PLIST] autorelease];
    Alphacon *alphacon = [[[Alphacon alloc] init] autorelease];
    
    if ([[dict objectForKey:@"Enabled"] boolValue]) {
        [alphacon changeSwitcherIcons:[self appIcons] forTweakState:YES]; 
    }
    else {
        [alphacon changeSwitcherIcons:[self appIcons] forTweakState:NO];
    }
    
    %orig;
}

%end

%hook SBDockIconListView 

-(void)compactIcons:(BOOL)icons {
    %orig;
    
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:PLIST] autorelease];
    Alphacon *alphacon = [[[Alphacon alloc] init] autorelease];
    
    [[dict objectForKey:@"Enabled"] boolValue] ? [alphacon changeDockIconsForTweakState:YES] : [alphacon changeDockIconsForTweakState:NO];
}

%end


                 