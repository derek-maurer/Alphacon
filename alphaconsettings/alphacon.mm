#import <Preferences/Preferences.h>

#define PLIST @"/var/mobile/Library/Preferences/com.homeschooldev.alphacon.plist"
#define MASTER @"/var/mobile/Library/Preferences/com.homeschooldev.alphaconmaster.plist"
#define LABELS @"/var/mobile/Library/Preferences/com.homeschooldev.alphaconlabels.plist"
 
static PSListController *sharedInstance = nil;

@interface alphaconListController: PSListController {}
-(void)twitter:(id)arg;
-(void)bug:(id)arg;
-(void)donate:(id)arg;
-(void)website:(id)arg;
-(NSArray *)specifierIDsForGroup:(int)group;
-(int)getSpecifierIndexFromSpecifiers:(NSArray *)specifiers ForId:(NSString *)string;
-(void)removeLabelSpecifiers:(BOOL)animated;
-(void)addLabelSpecifiers:(BOOL)animated;
-(void)removeAllSpecifiers:(BOOL)animated;
-(void)addAllSpecifiers:(BOOL)animated;
+(id)sharedObject;
@end

@implementation alphaconListController

+ (id)sharedObject
{
  @synchronized (self) {
    if (sharedInstance == nil) {
	sharedInstance = [[self alloc] init];
    }
  }
 
  return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
  @synchronized(self) {
      sharedInstance = [super allocWithZone:zone];
      return sharedInstance;
  }
 
  return nil;
}


- (id)specifiers {
	if(_specifiers == nil) {
	NSMutableArray *array = [self loadSpecifiersFromPlistName:@"alphacon" target:self];
	NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:PLIST] autorelease];
	
	if (![[dict objectForKey:@"Enabled"] boolValue]) {
	    NSArray *ids = [self specifierIDsForGroup:1];
	    int size = ids.count;
	    for (int i=0; i<size; i++) {
		int index = [self getSpecifierIndexFromSpecifiers:array ForId:[ids objectAtIndex:i]];
		NSLog(@"1");
		[array removeObjectAtIndex:index];
		NSLog(@"2");
	    }
	}
    else {
	if (![[dict objectForKey:@"Labels"] boolValue]) {
	    NSArray *ids = [self specifierIDsForGroup:2];
	    int size = ids.count;
	    for (int i=0; i<size; i++) {
		int index = [self getSpecifierIndexFromSpecifiers:array ForId:[ids objectAtIndex:i]];
		[array removeObjectAtIndex:index];
	    }
	}
	}
    _specifiers = array;
	[array retain];
	}
	return _specifiers;
}

-(int)getSpecifierIndexFromSpecifiers:(NSArray *)specifiers ForId:(NSString *)string {
    int size = specifiers.count;
    for (int i=0; i<size; i++) {
	if ([[[specifiers objectAtIndex:i] propertyForKey:@"id"] isEqualToString:string]) {
	    return i;
	}
    }
    return nil;
}

-(NSArray *)specifierIDsForGroup:(int)group {
    if (group == 1) {
	NSArray *ids = [[[NSArray alloc] initWithObjects:@"AlphaValueGroup",@"Slider",@"ChangeAlphaGroup",@"HomeScreenSwitch",@"FoldersSwitch",@"SwitcherSwitch",@"DockSwitch",@"HideLabelsGroup",@"LabelsSwitch",@"LabelsGroup",@"HomeScreenLabels",@"FoldersSwitchLabels",@"SwitcherSwitchLabels",@"DockSwitchLabels",nil] autorelease];
	return ids;
    }
    if (group == 2) {
	NSArray *ids = [[[NSArray alloc] initWithObjects:@"LabelsGroup",@"HomeScreenLabels",@"FoldersSwitchLabels",@"SwitcherSwitchLabels",@"DockSwitchLabels",nil] autorelease];
	return ids;
    }
    return nil;
}

-(void)website:(id)arg {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.homeschooldev.com"]];
}

-(void)twitter:(id)arg {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/homeschooldev"]];
}

-(void)bug:(id)arg {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:derek@homeschooldev.com?&subject=Alphacon%20bug"]];
}

-(void)donate:(id)arg {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=C2VUW8ZXX3XFC"]];
}

-(void)removeLabelSpecifiers:(BOOL)animated {
    NSMutableArray *specs = [[[NSMutableArray alloc] init] autorelease];
   
    NSArray *ids = [self specifierIDsForGroup:2];

    int size = ids.count;
    for (int i=0;i<size;i++) {
	[specs addObject:[self specifierForID:[ids objectAtIndex:i]]];
    }

    size = specs.count;

    for (int i=0;i<size; i++) {
	[self removeSpecifier:[specs objectAtIndex: i] animated:animated];
    }
}

-(void)addLabelSpecifiers:(BOOL)animated {
    NSArray *specs = [self loadSpecifiersFromPlistName:@"alphacon" target:self];
    NSArray *ids = [self specifierIDsForGroup:2];
    
    int size = ids.count;
    int index = 11;
    for (int i=0;i<size; i++) {
	int spec = [self getSpecifierIndexFromSpecifiers:specs ForId:[ids objectAtIndex:i]];
	[self insertSpecifier:[specs objectAtIndex:spec] atIndex:index animated:animated];
	index++;
    }
}

-(void)removeAllSpecifiers:(BOOL)animated {

    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:PLIST] autorelease];
    NSMutableArray *specs = [[[NSMutableArray alloc] init] autorelease];
   
   NSArray *ids = [self specifierIDsForGroup:1];

   if (![[dict objectForKey:@"Labels"] boolValue]) {
       [self addLabelSpecifiers:NO];
   }

   int size = ids.count;
   for (int i=0;i<size;i++) {
       [specs addObject:[self specifierForID:[ids objectAtIndex:i]]];
   }

    size = specs.count;

    for (int i=0;i<size; i++) {
      
	[self removeSpecifier:[specs objectAtIndex: i] animated:animated];
	
    }
}

-(void)addAllSpecifiers:(BOOL)animated {
    
    NSMutableArray *array = [self loadSpecifiersFromPlistName:@"alphacon" target:self];
    
    NSMutableArray *ids = [[[NSMutableArray alloc] init] autorelease];
    [ids addObjectsFromArray:[self specifierIDsForGroup:1]];
    
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:PLIST] autorelease];
    
    if (![[dict objectForKey:@"Labels"] boolValue]) {
	for (int index=9; index<14; index++) {
	    [ids removeLastObject];
	}
    }
    
    int size = ids.count;
    int index = 2;
    for (int i=0;i<size; i++) {
	int spec = [self getSpecifierIndexFromSpecifiers:array ForId:[ids objectAtIndex:i]];
	[self insertSpecifier:[array objectAtIndex:spec] atIndex:index animated:animated];
	index++;
    }
}

@end

#define PLIST @"/var/mobile/Library/Preferences/com.homeschooldev.alphacon.plist"

static void alphaEnabled(CFNotificationCenterRef center,
void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:PLIST] autorelease];
    
    alphaconListController *controller = [alphaconListController sharedObject];
    
    if ([[dict objectForKey:@"Enabled"] boolValue]) {
	[controller addAllSpecifiers:YES];
    }
    else {
	[controller removeAllSpecifiers:YES];
    }
}

static void labelsEnabled(CFNotificationCenterRef center, 
void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:PLIST] autorelease];

    alphaconListController *controller = [alphaconListController sharedObject];
    
    if ([[dict objectForKey:@"Labels"] boolValue]) {
	[controller addLabelSpecifiers:YES];
    }
    else {
	[controller removeLabelSpecifiers:YES];
    }
}

//Constructors...
static __attribute__((constructor)) void awesomeInitFunction() {
CFNotificationCenterRef r = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterAddObserver(r, NULL, &alphaEnabled,
    CFSTR("com.homeschooldev.alphacon/enabled"), NULL, 0); 
}

static __attribute__((constructor)) void anotherInitFunction() {
    CFNotificationCenterRef r = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterAddObserver(r, NULL, &labelsEnabled,
				    CFSTR("com.homeschooldev.alphacon/labels"), NULL, 0); 
}





