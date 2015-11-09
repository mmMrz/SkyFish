//
//  KeyBoardNotification.m
//  SmartPay
//
//  Created by Zhang on 14-10-11.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "KeyBoardNotification.h"

@interface KeyBoardNotification(){
    CGFloat currentKeyboardTop;
}

@end

@implementation KeyBoardNotification

+ (KeyBoardNotification *)sharedInstance {
    static KeyBoardNotification *sharedKeyBoardNotificationInstance = nil;
    
    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
        sharedKeyBoardNotificationInstance = [[self alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:sharedKeyBoardNotificationInstance selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:sharedKeyBoardNotificationInstance selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:sharedKeyBoardNotificationInstance selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:sharedKeyBoardNotificationInstance selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
        
    });
    
    return sharedKeyBoardNotificationInstance;
}

- (void)setupWithViewController:(UIViewController*)viewController
{
    _viewController = viewController;
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    CGFloat keyboardTop = _viewController.view.frame.size.height - keyboardRect.size.height;
    
    currentKeyboardTop = keyboardTop;
    
    UIView *theTextFieldOrTextView = [_viewController.view firstResponder];
    
    CGFloat shouldMove = 0;
    
    id textView = theTextFieldOrTextView;
    UITextRange *startTextRange = [textView characterRangeAtPoint:CGPointZero];
    CGRect caretRect = [textView caretRectForPosition:startTextRange.end];
    CGFloat lineHeight = CGRectGetHeight(caretRect);
    
    caretRect = [textView caretRectForPosition:[textView selectedTextRange].end];
    CGFloat caretTop = CGRectGetMinY(caretRect);
    
//    CGRect textViewFrame = [[textView superview] frame];
    CGRect textViewFrame = [_viewController.view convertRect:textViewFrame fromView:textView];
    textViewFrame.size = [textView frame].size;
    CGFloat cursorBottom = caretTop+textViewFrame.origin.y+lineHeight;
    if (caretTop+lineHeight>textViewFrame.size.height) {
        cursorBottom = textViewFrame.origin.y+textViewFrame.size.height;
    }
    
    if (cursorBottom>keyboardTop) {
        shouldMove = cursorBottom - keyboardTop;
    }
    CGRect newViewFrame = _viewController.view.bounds;
    if (_viewController.navigationController.navigationBarHidden) {
        newViewFrame.origin.y=0;
    }else{
        newViewFrame.origin.y=64;
    }
    newViewFrame.origin.y-=shouldMove;
    _viewController.view.frame = newViewFrame;
}

- (void)keyboardWillChangeFrame:(NSNotification*)notification
{
    //固定键盘时这里不需要操作
//    NSDictionary *userInfo = [notification userInfo];
//    
//    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    
//    CGRect keyboardRect = [aValue CGRectValue];
//    keyboardRect = [_viewController.view convertRect:keyboardRect fromView:nil];
//    currentKeyboardFrame = keyboardRect;
//    CGFloat keyboardTop = keyboardRect.origin.y;
//    
//    UIView *theTextFieldOrTextView = [_viewController.view firstResponder];
//    
//    CGRect textFieldFrame = [_viewController.view convertRect:theTextFieldOrTextView.frame fromView:theTextFieldOrTextView.superview];
//    CGFloat textFieldBottom = textFieldFrame.origin.y+textFieldFrame.size.height;
//    
//    CGFloat shouldMove = 0;
//    if (textFieldBottom>keyboardTop) {
//        /*
//         *这样就应该去移动一下self.view了
//         *移动的像素为textFieldBottom与keyboardTop之间的差
//         */
//        shouldMove = textFieldBottom-keyboardTop;
//        
//    }
//    CGRect newViewFrame = _viewController.view.frame;
//    newViewFrame.origin.y-=shouldMove;
//    
//    _viewController.view.frame = newViewFrame;
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    CGRect newViewFrame = _viewController.view.bounds;
    if (_viewController.navigationController.navigationBarHidden) {
        newViewFrame.origin.y=0;
    }else{
        newViewFrame.origin.y=64;
    }
    _viewController.view.frame = newViewFrame;
    
}

- (void)textViewDidChange:(NSNotification*)notification
{
    UITextView *textView = [notification object];
    
    CGFloat shouldMove = 0;
    
    UITextRange *startTextRange = [textView characterRangeAtPoint:CGPointZero];
    CGRect caretRect = [textView caretRectForPosition:startTextRange.end];
    CGFloat topMargin = CGRectGetMinY(caretRect);
    CGFloat lineHeight = CGRectGetHeight(caretRect);
    
    caretRect = [textView caretRectForPosition:[textView selectedTextRange].end];
    CGFloat caretTop = CGRectGetMinY(caretRect);
    
    CGRect textViewFrame = [[textView superview] frame];
    
    CGFloat cursorBottom = textViewFrame.origin.y+caretTop+lineHeight;
    if (caretTop+lineHeight>textViewFrame.size.height) {
        cursorBottom = textViewFrame.origin.y+textViewFrame.size.height;
    }
    
    if (cursorBottom>currentKeyboardTop) {
        shouldMove = cursorBottom - currentKeyboardTop;
    }
    CGRect newViewFrame = _viewController.view.bounds;
    if (_viewController.navigationController.navigationBarHidden) {
        newViewFrame.origin.y=0;
    }else{
        newViewFrame.origin.y=64;
    }
    newViewFrame.origin.y-=shouldMove;
    _viewController.view.frame = newViewFrame;}

@end
