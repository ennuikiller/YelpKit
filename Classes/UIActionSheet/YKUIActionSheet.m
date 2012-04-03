//
//  YKUIActionSheet.m
//  YelpIPhone
//
//  Created by Gabriel Handford on 6/29/10.
//  Copyright 2010 Yelp. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "YKUIActionSheet.h"

#import <GHKitIOS/GHNSArray+Utils.h>

@implementation YKUIActionSheet

@synthesize actionSheetStyle=_actionSheetStyle;

- (id)initWithTitle:(NSString *)title target:(id)target cancelButtonTitle:(NSString *)cancelButtonTitle cancelAction:(SEL)cancelAction
  destructiveButtonTitle:(NSString *)destructiveButtonTitle destructiveAction:(SEL)destructiveAction {

  if ((self = [self init])) {
    _title = [title retain];
    _target = target;
    _actionSheetStyle = UIActionSheetStyleDefault;
    
    _cancelButtonTitle = [cancelButtonTitle retain];
    _cancelAction = [[NSValue valueWithPointer:cancelAction] retain];

    _destructiveButtonTitle = [destructiveButtonTitle retain];
    _destructiveAction = [[NSValue valueWithPointer:destructiveAction] retain];

    _titles = [[NSMutableArray alloc] initWithCapacity:10];
    _actions = [[NSMutableArray alloc] initWithCapacity:10];
  }
  return self;
}

- (void)dealloc {
  [_title release];
  [_cancelButtonTitle release];
  [_cancelAction release];
  [_destructiveButtonTitle release];
  [_destructiveAction release];
  [_actionSheet release];
  [_titles release];
  [_actions release];
  [super dealloc];
}

- (UIActionSheet *)actionSheet {
  if (!_actionSheet) {
    // Initialize the buttons from the array. This is a hack since there's no way to pass in an array to the nil-terminated list
    _actionSheet = [[UIActionSheet alloc] initWithTitle:_title delegate:self cancelButtonTitle:_cancelButtonTitle destructiveButtonTitle:_destructiveButtonTitle otherButtonTitles:[_titles gh_objectAtIndex:0], [_titles gh_objectAtIndex:1], [_titles gh_objectAtIndex:2], [_titles gh_objectAtIndex:3], [_titles gh_objectAtIndex:4], [_titles gh_objectAtIndex:5], [_titles gh_objectAtIndex:6], [_titles gh_objectAtIndex:7], [_titles gh_objectAtIndex:8], nil];
    _actionSheet.actionSheetStyle = _actionSheetStyle;
    // Add cancel and destructive buttons to actions at their correct indices
    if (_destructiveButtonTitle) [_actions insertObject:_destructiveAction atIndex:[_actionSheet destructiveButtonIndex]];
    if (_cancelButtonTitle) [_actions insertObject:_cancelAction atIndex:[_actionSheet cancelButtonIndex]];
  }
  return _actionSheet;
}

- (void)addButtonWithTitle:(NSString *)title action:(SEL)action {
  [_titles addObject:title];
  [_actions addObject:[NSValue valueWithPointer:action]];
}

- (void)showFromToolbar:(UIToolbar *)view {   
  [[self actionSheet] showFromToolbar:view]; 
  [self retain]; // Release in delegate below
}

- (void)showFromTabBar:(UITabBar *)view { 
  [[self actionSheet] showFromTabBar:view]; 
  [self retain]; // Release in delegate below
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated {
  [[self actionSheet] showFromBarButtonItem:item animated:animated];
  [self retain]; // Release in delegate below
}

- (void)showInView:(UIView *)view { 
  if (!view) return;
  [[self actionSheet] showInView:view]; 
  [self retain]; // Release in delegate below
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated {
  [[self actionSheet] showFromRect:rect inView:view animated:animated];
  [self retain]; // Release in delegate below
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
  [[self actionSheet] dismissWithClickedButtonIndex:buttonIndex animated:animated];
}

- (void)cancel {
  [self dismissWithClickedButtonIndex:[_actionSheet cancelButtonIndex] animated:YES];
}

#pragma mark Delegates (UIActionSheet)

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
  id obj = [_actions objectAtIndex:buttonIndex];
  if (obj != [NSNull null]) {
    NSValue *actionValue = (NSValue *)obj;
    SEL selector = [actionValue pointerValue];
    // Handle nil selectors
    if (selector != nil)
      [_target performSelector:selector withObject:self];
  }
  // Release for the retain from show
  _actionSheet.delegate = nil;
  [self autorelease];
}

@end
