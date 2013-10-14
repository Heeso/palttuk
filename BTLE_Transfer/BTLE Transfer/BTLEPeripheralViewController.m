/*
 
 File: LEPeripheralViewController.m
 
 Abstract: Interface to allow the user to enter data that will be
 transferred to a version of the app in Central Mode, when it is brought
 close enough.
 
 Version: 1.0
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by
 Apple Inc. ("Apple") in consideration of your agreement to the
 following terms, and your use, installation, modification or
 redistribution of this Apple software constitutes acceptance of these
 terms.  If you do not agree with these terms, please do not use,
 install, modify or redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc.
 may be used to endorse or promote products derived from the Apple
 Software without specific prior written permission from Apple.  Except
 as expressly stated in this notice, no other rights or licenses, express
 or implied, are granted by Apple herein, including but not limited to
 any patent rights that may be infringed by your derivative works or by
 other works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2012 Apple Inc. All Rights Reserved.
 
 */

#import "BTLEPeripheralViewController.h"
#import "BTLEPeripheralManager.h"


@interface BTLEPeripheralViewController ()
@property (strong, nonatomic) IBOutlet UISwitch         *advertisingSwitch;
@end



#define NOTIFY_MTU      20



@implementation BTLEPeripheralViewController



#pragma mark - View Lifecycle



- (void)viewDidLoad
{
    [super viewDidLoad];

    // Start up the CBPeripheralManager
    [BTLEPeripheralManager sharedInstance];
}


- (void)viewWillDisappear:(BOOL)animated
{
    // Don't keep it going while we're not showing.
    [[BTLEPeripheralManager sharedInstance] stopAdvertise];

    [super viewWillDisappear:animated];
}

//
//
//#pragma mark - TextView Methods
//
//
//
///** This is called when a change happens, so we know to stop advertising
// */
//- (void)textViewDidChange:(UITextView *)textView
//{
//    // If we're already advertising, stop
//    if (self.advertisingSwitch.on) {
//        [self.advertisingSwitch setOn:NO];
//        [self.peripheralManager stopAdvertising];
//    }
//}
//
//
///** Adds the 'Done' button to the title bar
// */
//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    // We need to add this manually so we have a way to dismiss the keyboard
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard)];
//    self.navigationItem.rightBarButtonItem = rightButton;
//}
//
//
///** Finishes the editing */
//- (void)dismissKeyboard
//{
//    [self.textView resignFirstResponder];
//    self.navigationItem.rightBarButtonItem = nil;
//}
//


#pragma mark - Switch Methods



/** Start advertising
 */
- (IBAction)switchChanged:(id)sender
{
    if (self.advertisingSwitch.on) {
        // All we advertise is our service's UUID
        [[BTLEPeripheralManager sharedInstance] startAdvertise];
    }
    
    else {
        [[BTLEPeripheralManager sharedInstance] stopAdvertise];
//        [self.peripheralManager stopAdvertising];
    }
}


@end
