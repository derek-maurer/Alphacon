#import <SpringBoard/SBIconController.h>
#import <SpringBoard/SBUIController.h>
#import <SpringBoard/SBIcon.h>
#import <SpringBoard/SpringBoard.h>
#import "SBFolder.h"
#import "SBFolderIcon.h"
#import "SBAppSwitcherBarView.h"
#import "SBDockIconListView.h"
#import "SBIconListView.h"

@interface SBIcon (x)
-(void)setIconImageAlpha:(float)alpha;
-(void)setIconLabelAlpha:(float)alpha;
@end

@interface SBIconController (x) 
-(id)folderIconListAtIndex:(unsigned)index;
-(id)iconListViewAtIndex:(unsigned)index inFolder:(id)folder createIfNecessary:(BOOL)necessary;
-(BOOL)hasOpenFolder;
@end

@interface SpringBoard (iOS4)
- (id)_accessibilityTopDisplay;
@end