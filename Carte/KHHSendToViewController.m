                                                                                                                                                                                                              //
//  KHHSendToViewController.m
//  CardBook
//
//  Created by 王国辉 on 12-8-22.
//  Copyright (c) 2012年 KingHanHong. All rights reserved.
//

#import "KHHSendToViewController.h"

#import <AddressBookUI/AddressBookUI.h>
#import "NSString+Validation.h"
#import "JSTokenField.h"
#import "Card.h"
#import "NetClient+ToPaths.h"
#import "MBProgressHUD.h"

#define TheScrollMaxHeight 180
#define TheScrollMinHeight 42
#define TheScrollHeightPadding 5

#define textCardSent NSLocalizedString(@"名片发送成功", @"")
#define textOK NSLocalizedString(KHHMessageSure, @"")

@implementation CardReceiver
@synthesize name = _name;
@synthesize mobile = _mobile;

- (CardReceiver *)initWithName:(NSString *)name andMobile:(NSString *)mobile
{
    self = [super init];
    if (self) {
        if (name) {
            _name = [[NSString alloc] initWithString:name];
        }
        if (mobile) {
            _mobile = [[NSString alloc] initWithString:mobile];
        }
    }
    return self;
}
@end

@interface KHHSendToViewController ()<UIAlertViewDelegate,ABPeoplePickerNavigationControllerDelegate,JSTokenFieldDelegate>
@property (strong, nonatomic) NSMutableArray *theReceivers;

@end

@implementation KHHSendToViewController

{
    MBProgressHUD *_hud;
}

@synthesize theScroll = _theScroll;
@synthesize theTokenField = _theTokenField;
@synthesize theBgView = _theBgView;
@synthesize theReceivers = _theReceivers;
@synthesize theCard = _theCard;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _theReceivers = [[NSMutableArray alloc] init];
        
        self.title = NSLocalizedString(@"发送至手机", nil);
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleTokenFieldFrameDidChange:)
                                                     name:JSTokenFieldFrameDidChangeNotification
                                                   object:nil];
        

    }
    return self;
}
- (void)leftBarClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
//发送
- (void)rightBarButtonClick:(id)sender
{
//    [self observeNotificationName:KHHUIReplyCardSucceeded selector:@"handleSendCardToPhoneSucceeded:"];
//    [self observeNotificationName:KHHUIReplyCardFailed selector:@"handleSendCardToPhoneFailed:"];
    [self sendToReceivers];
}
- (void)sendToReceivers{
    //发送成功跳转到前一页,thecard 只是声明了下
#ifdef DEBUG
    NSLog(@"发送按钮！");
#endif
    if ([self tokenFieldShouldReturn:self.theTokenField]) {
#ifdef DEBUG
        NSLog(@"接受者：%@", self.theReceivers);
#endif
        if(_theReceivers.count==0){
            [[[UIAlertView alloc] initWithTitle:@"手机号码为空!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            return;
        }
        
        if (self.theCard) {
            //
            if (self.theReceivers.count) {
                //把token里的手机号取出添加到目标数组中
                NSMutableArray *mobileArray = [[NSMutableArray alloc] initWithCapacity:0];
                NSMutableString *strPro = [[NSMutableString alloc]initWithCapacity:[_theReceivers count]];
                for (int i=0;i<[_theReceivers count];i++) {
                    CardReceiver *cr = (CardReceiver *)_theReceivers[i];
                    [mobileArray addObject:cr.mobile];
                    if (i==0) {
                        [strPro appendString:cr.mobile];
                        continue;
                    }
                    [strPro appendFormat:@"|%@",cr.mobile];
                }
#ifdef DEBUG
                NSLog(@"接受者mobileArray：%@", mobileArray);
#endif
                
//                [[KHHDataNew sharedData] doSendByPhone:mobileArray cardId:[NSString stringWithFormat:@"%lld",self.theCard.idValue] delegate:self];
                NSMutableDictionary *dicParam = [[NSMutableDictionary alloc]initWithCapacity:2];
                dicParam[@"id"] = _theCard.id;
                dicParam[@"mobiles"] = strPro;
                
                _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                _hud.labelText = @"发送名片";
               [[NetClient sharedClient]doInselfPath:@"post" methodPath:@"mobile/card/send" parameters:dicParam success:^(NSMutableDictionary *responseDict) {
                   [_hud hide:YES];
                   [[[UIAlertView alloc] initWithTitle:@"发送成功"
                                               message:nil
                                              delegate:self
                                     cancelButtonTitle:@"确定"
                                     otherButtonTitles:nil] show];
               } failure:^(NSMutableDictionary *responseDict) {
                   [_hud hide:YES];
                   if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:1]]) {
                       responseDict[@"note"] = @"对方已有你的名片，无需发送";
                   }
                   [[[UIAlertView alloc] initWithTitle:@"发送失败"
                                               message:responseDict[@"note"]
                                              delegate:self
                                     cancelButtonTitle:@"确定"
                                     otherButtonTitles:nil] show];
               }];
                
            }
        } else {
            // theCard 为 nil
            NSLog(@"theCard 为 %@", self.theCard);
        }
    }
}
#pragma mark -
- (void)handleSendCardToPhoneSucceeded:(NSNotification *)info{
   
   // DLog(@"handleSendCardToPhoneSucceeded! ====== info is %@",info.userInfo);
    NSString *message;
    if ([[info.userInfo objectForKey:@"errorCode"] intValue] == 1) {
        message = @"对方已有你的名片，无需发送";
    }else if([[info.userInfo objectForKey:@"errorCode"] intValue] == 0) {
        message = textCardSent;
    }else {
        message = @"发送失败，请稍后再试";
    }
#ifdef DEBUG
    NSLog(@"发送结果message：%@", message);
#endif
    [[[UIAlertView alloc] initWithTitle:nil
                                message:message
                               delegate:self
                      cancelButtonTitle:@"确定"
                      otherButtonTitles:nil] show];

}
- (void)handleSendCardToPhoneFailed:(NSNotification *)info{
    
    //DLog(@"handleSendCardToPhoneFailed! ====== info is %@",info.userInfo);
    [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"发送失败，请稍后再试"
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil] show];
}
#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.barLeftStr = @"取消";
    self.barRightStr = @"发送";
    KHHSendToViewController *weakSelf = self;
    self.barRightAction = ^(){[weakSelf sendToReceivers];};
    
    // Do any additional setup after loading the view from its nib.
    self.theTokenField = [[JSTokenField alloc] initWithFrame:CGRectMake(0, TheScrollHeightPadding, 310, 32)];
    [self.theScroll addSubview:self.theTokenField];
    self.theTokenField.backgroundColor = [UIColor whiteColor];
    self.theTokenField.delegate = self;
    //self.theTokenField.label.text = @"To:";
    self.theTokenField.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    UIButton *theAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
    theAddButton.frame = CGRectMake(0, 1, 45, 40);
    //[theAddButton setTitle:NSLocalizedString(@"添加", nil) forState:UIControlStateNormal];
    [theAddButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [theAddButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [theAddButton setBackgroundImage:[[UIImage imageNamed:@"addBtnimg.png"] stretchableImageWithLeftCapWidth:2 topCapHeight:0] forState:UIControlStateNormal];
    [theAddButton addTarget:self action:@selector(theAddButtonTapped) forControlEvents:UIControlEventTouchDown];
    self.theTokenField.textField.rightView = theAddButton;
    self.theTokenField.textField.rightViewMode = UITextFieldViewModeAlways;
    [self.theTokenField.textField becomeFirstResponder];
    
    theBgView_y = self.theBgView.frame.origin.y;
    theScroll_y = self.theScroll.frame.origin.y;
}



- (void)theAddButtonTapped
{
    ABPeoplePickerNavigationController *aPeoplePicker = [[ABPeoplePickerNavigationController alloc] init];
    aPeoplePicker.peoplePickerDelegate = self;
    if ([UIViewController instancesRespondToSelector:@selector(presentViewController:animated:completion:)]) {
        // 5.0 以上
        [self presentViewController:aPeoplePicker animated:YES completion:nil];
    } else{
        [self presentModalViewController:aPeoplePicker animated:YES];
    }
}
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    if ([UIViewController instancesRespondToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        // 5.0 以上
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    } else{
        [peoplePicker dismissModalViewControllerAnimated:YES];
    }

}
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    // 从通讯录获取姓名和电话
//    NSString *aName = (__bridge NSString *)ABRecordCopyCompositeName(person);;
    NSString *aName = CFBridgingRelease(ABRecordCopyCompositeName(person));
    ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSString *aPhone = nil;
    CFIndex n = ABMultiValueGetCount(phones);
    if (0 == n) {
        [[[UIAlertView alloc]
           initWithTitle:nil
           message:NSLocalizedString(@"该联系人无电话", nil)
           delegate:nil
           cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
           otherButtonTitles:nil]
           show];
        CFRelease(phones);
        return NO;
    }
    if (n == 1) {
//        NSString *aPhoneRef = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phones,0);
        NSString *aPhoneRef = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones,0));
        aPhone = [self retrievePhoneNumberFromString:aPhoneRef];
        if (aPhone.isRegistrablePhone) {
            //
            //            [peoplePicker dismissViewControllerAnimated:YES completion:nil];
            if ([UIViewController instancesRespondToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
                // 5.0 以上
                [peoplePicker dismissViewControllerAnimated:YES completion:nil];
            } else{
                [peoplePicker dismissModalViewControllerAnimated:YES];
            }
            // 生成Receiver并添加为token
           
            if (![self isHaveInReceivers:aPhone]) {
                CardReceiver *aReceiver = [[CardReceiver alloc] initWithName:aName andMobile:aPhone];
                
                [self.theTokenField addTokenWithTitle:(aName.length?aName:aPhone) representedObject:aReceiver];
            }
        
        } else {
            //
            [[[UIAlertView alloc]
               initWithTitle:nil
               message:NSLocalizedString(@"该联系人的电话号码不是有效的手机号", nil)
               delegate:nil
               cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
               otherButtonTitles:nil]
               show];
        }
        CFRelease(phones);
        return NO;
    }
    CFRelease(phones);
    return YES;
}

#pragma mark - theReceivers isHave

- (Boolean)isHaveInReceivers:(NSString *)phone
{
    for (CardReceiver *receiver in _theReceivers) {
        if ([receiver.mobile isEqualToString:phone]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    NSString *aName = CFBridgingRelease(ABRecordCopyCompositeName(person));
    NSString *aPhone = nil;
    ABMultiValueRef phones = ABRecordCopyValue(person, property);
    if (identifier != kABMultiValueInvalidIdentifier) {
        NSString *aPhoneRef = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, identifier));
        aPhone = [self retrievePhoneNumberFromString:aPhoneRef];
        if (aPhone.isRegistrablePhone) {
            //
            //            [peoplePicker dismissViewControllerAnimated:YES completion:nil];
            if ([UIViewController instancesRespondToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
                // 5.0 以上
                [peoplePicker dismissViewControllerAnimated:YES completion:nil];
            } else{
                [peoplePicker dismissModalViewControllerAnimated:YES];
            }
            // 生成Receiver并添加为token
            if (![self isHaveInReceivers:aPhone]) {
                CardReceiver *aReceiver = [[CardReceiver alloc] initWithName:aName andMobile:aPhone];
                
                [self.theTokenField addTokenWithTitle:(aName.length?aName:aPhone) representedObject:aReceiver];
            }
        } else {
            //
            [[[UIAlertView alloc]
               initWithTitle:nil
               message:NSLocalizedString(@"该电话号码不是有效的手机号", nil)
               delegate:nil
               cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
               otherButtonTitles:nil]
               show];
        }
    }
    CFRelease(phones);
    return NO;

}

- (NSString *)retrievePhoneNumberFromString:(NSString *)string
{
    NSMutableString *aPhone = [NSMutableString stringWithCapacity:11];
    NSCharacterSet *numberSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSScanner *scanner = [NSScanner scannerWithString:string];
    while ([scanner isAtEnd] == NO) {
        NSString *tmpString = @"";
        [scanner scanUpToCharactersFromSet:numberSet intoString:NULL];
        if([scanner scanCharactersFromSet:numberSet intoString:&tmpString])
            [aPhone appendString:tmpString];
    }
    return aPhone;
}
- (void)handleTokenFieldFrameDidChange:(NSNotification *)note
{
	if ([[note object] isEqual:self.theTokenField])
	{
		[UIView animateWithDuration:1.0f
						 animations:^{
                             [self resizeTheScroll];
                             CGFloat theContentHeight = self.theScroll.contentSize.height;
                             CGFloat theScrollHeight = self.theScroll.frame.size.height;
                             if (theContentHeight > theScrollHeight) {
                                 CGPoint newPoint = {0, theContentHeight - theScrollHeight};
                                 self.theScroll.contentOffset = newPoint;
                             }
						 }
						 completion:nil];
	}
}
- (void)resizeTheScroll
{
    CGSize theFieldSize = self.theTokenField.frame.size;
    CGSize theContentSize = self.theScroll.contentSize;
    theContentSize.height = theFieldSize.height + (TheScrollHeightPadding * 2);
    self.theScroll.contentSize = theContentSize;
    
    if (theContentSize.height >= TheScrollMinHeight && theContentSize.height <= TheScrollMaxHeight) {
        CGRect aFrame = self.theScroll.frame;
        aFrame.size.height = theContentSize.height;
        self.theScroll.frame = aFrame;
    }
}


- (BOOL)makeTokenAndReceiverFromString:(NSString *)string
{
    if (string.length > 1)
	{
        NSString *aPhone = [self retrievePhoneNumberFromString:string];
        if (aPhone.isRegistrablePhone) {
            // 生成Receiver并添加为token
            CardReceiver *aReceiver = [[CardReceiver alloc] initWithName:@"" andMobile:aPhone];
            [self.theTokenField addTokenWithTitle:aReceiver.mobile representedObject:aReceiver];
            return YES;
        } else {
            //
            [[[UIAlertView alloc]
               initWithTitle:nil
               message:NSLocalizedString(@"未输入可用的手机号", nil)
               delegate:nil
               cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
               otherButtonTitles:nil]
               show];
        }
        return NO;
	}
    return YES;
}

#pragma mark - tokenFiled delegate

- (BOOL)tokenFieldShouldReturn:(JSTokenField *)tokenField {
    NSString *rawStr = [[tokenField textField] text];
#ifdef DEBUG
    NSLog(@"tokenField textField:%@, length:%d",rawStr,rawStr.length);
#endif
    return [self makeTokenAndReceiverFromString:rawStr];
}
- (void)tokenField:(JSTokenField *)tokenField didAddToken:(NSString *)title representedObject:(id)obj
{
    CardReceiver *aReceiver = (CardReceiver *)obj;
	[self.theReceivers addObject:aReceiver];
    [tokenField becomeFirstResponder];
	NSLog(@"Added token for < %@ : %@ >\n%@", title, obj, self.theReceivers);
}

- (void)tokenField:(JSTokenField *)tokenField didRemoveTokenAtIndex:(NSUInteger)index
{
	[self.theReceivers removeObjectAtIndex:index];
	NSLog(@"Deleted token %d\n%@", index, self.theReceivers);
}

- (void)tokenFieldDidEndEditing:(JSTokenField *)tokenField
{
    NSLog(@"Deleted token %@", self.theReceivers);

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//发送成功，返回上个界面
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
//    if (alertView.tag == KHHAlertMessage||alertView.tag == KHHAlertContact) {
//        return;
//    }
    
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - transCard delegate

- (void)sendByPhoneForUISuccess
{
    NSString *message = textCardSent;
//    if ([[info.userInfo objectForKey:@"errorCode"] intValue] == 1) {
//        message = @"对方已有你的名片，无需发送";
//    }else if([[info.userInfo objectForKey:@"errorCode"] intValue] == 0) {
//        message = textCardSent;
//    }else {
//        message = @"发送失败，请稍后再试";
//    }
//#ifdef DEBUG
//    NSLog(@"发送结果message：%@", message);
//#endif
    [[[UIAlertView alloc] initWithTitle:nil
                                message:message
                               delegate:self
                      cancelButtonTitle:@"确定"
                      otherButtonTitles:nil] show];
}

- (void)sendByPhoneForUIFailed:(NSDictionary *)dict
{
    [[[UIAlertView alloc] initWithTitle:@"发送失败"
                                message:nil
                               delegate:nil
                      cancelButtonTitle:@"确定"
                      otherButtonTitles:nil] show];
}



@end
