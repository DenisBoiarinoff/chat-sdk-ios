//
//  BChatOptionsActionSheet.m
//  Pods
//
//  Created by Benjamin Smiley-andrews on 18/12/2016.
//
//

#import "BChatOptionsActionSheet.h"

#import <ChatSDK/Core.h>
#import <ChatSDK/UI.h>

@implementation BChatOptionsActionSheet

-(instancetype) initWithDelegate: (id<BChatOptionDelegate>) delegate {
    if((self = [self init])) {
        self.delegate = delegate;
        
        _options = BChatSDK.ui.chatOptions;
                
    }
    return self;
}

-(BOOL) show {
  [_delegate hideKeyboard];
  
  UIViewController *vc = (UIViewController *)_delegate;
  
  UIAlertController *actionSheet = [UIAlertController
    alertControllerWithTitle:[NSBundle t:bOptions]
    message:Nil
    preferredStyle:UIAlertControllerStyleActionSheet];
  UIAlertAction* defaultAction = [UIAlertAction
    actionWithTitle:[NSBundle t:bOk]
    style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * action) {
      [vc dismissViewControllerAnimated:true completion:nil];
    }];
  [actionSheet addAction:defaultAction];
    
  if (_options.count) {
    NSNumber *counter = @0;
    for (BChatOption * option in _options) {
      int current = [counter intValue];
      UIAlertAction* currentAction = [UIAlertAction
        actionWithTitle:option.title
        style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {
          BChatOption * option = self->_options[current];
          [vc dismissViewControllerAnimated:true completion:nil];
          [option execute:self->_delegate.currentViewController threadEntityID:self->_delegate.threadEntityID];
        }];
      [actionSheet addAction:currentAction];
      counter = [[NSNumber alloc] initWithInt:current + 1];
    }
    [vc presentViewController:actionSheet animated:true completion:Nil];
  }
  else {
      // TODO: hide the option button
  }
  return NO;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex) {
        BChatOption * option = _options[buttonIndex - 1];
        [option execute:_delegate.currentViewController threadEntityID:_delegate.threadEntityID];
    }
}

-(UIView *) keyboardView {
    return Nil;
}

-(BOOL) hide {
    return NO;
}

-(void) presentView: (UIView *) view {
    
}

-(void) dismissView {
    
}


@end
