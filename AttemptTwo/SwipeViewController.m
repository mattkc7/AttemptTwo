//
//  SwipeViewController.m
//  AttemptTwo
//
//  Created by mchan2 on 11/1/14.
//  Copyright (c) 2014 MatthewChan. All rights reserved.
//

#import "SwipeViewController.h"

@interface SwipeViewController ()

@end

@implementation SwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Enable info level NSLogs inside SDK
    // Here we turn on before initializing SDK object so the act of initializing is logged
    [uniMag enableLogging:true];
    
    // Initialize the SDK by creating a uniMag class object
    self.uniMag = [[uniMag alloc] init];
    
    // Set SDK to perform the connect task automatically when headset is attached
    [self.uniMag setAutoConnect:false];
    
    // Set swipe timeout to infinite. By default, swipe task will timeout after 20 seconds
    [self.uniMag setSwipeTimeoutDuration:0];
    
    // Make SDK maximize the volume automatically during connection
    [self.uniMag setAutoAdjustVolume:true];
    
    // By default, the diagnostic wave file logged by the SDK is stored under the temp directory
    // Here it is set to be under the Documents folder in the app sandbox so the log can be accessed
    // through iTunes file sharing. See UIFileSharingEnabled in iOS doc.
    [self.uniMag setWavePath: [NSHomeDirectory() stringByAppendingPathComponent: @"/Documents/audio.caf"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//-----------------------------------------------------------------------------
#pragma mark - UniMag SDK activation/deactivation -
//-----------------------------------------------------------------------------

- (void)uniMag_activate {
    [self.uniMag startUniMag:true];
    [self uniMag_registerObservers:true];
    [self displayDeviceStatus];
}

-(void)uniMag_deactivate {
    if (self.uniMag != NULL && self.uniMag.getConnectionStatus)
    {
        [self.uniMag startUniMag:false];
    }
    
    [self uniMag_registerObservers:false];
    [self displayDeviceStatus];
}

-(void)displayDeviceStatus {
    
}

//-----------------------------------------------------------------------------
#pragma mark - UniMag SDK observers -
//-----------------------------------------------------------------------------

-(void) uniMag_registerObservers:(BOOL) reg {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    if (reg) {
        [nc addObserver:self selector:@selector(umDevice_attachment:) name:uniMagAttachmentNotification object:nil];
        [nc addObserver:self selector:@selector(umDevice_detachment:) name:uniMagDetachmentNotification object:nil];
        [nc addObserver:self selector:@selector(umConnection_lowVolume:) name:uniMagInsufficientPowerNotification object:nil];
        [nc addObserver:self selector:@selector(umConnection_starting:) name:uniMagPoweringNotification object:nil];
        [nc addObserver:self selector:@selector(umConnection_timeout:) name:uniMagTimeoutNotification object:nil];
        [nc addObserver:self selector:@selector(umConnection_connected:) name:uniMagDidConnectNotification object:nil];
        [nc addObserver:self selector:@selector(umConnection_disconnected:) name:uniMagDidDisconnectNotification object:nil];
        [nc addObserver:self selector:@selector(umSwipe_starting:) name:uniMagSwipeNotification object:nil];
        [nc addObserver:self selector:@selector(umSwipe_timeout:) name:uniMagTimeoutSwipeNotification object:nil];
        [nc addObserver:self selector:@selector(umDataProcessing:) name:uniMagDataProcessingNotification object:nil];
        [nc addObserver:self selector:@selector(umSwipe_invalid:) name:uniMagInvalidSwipeNotification object:nil];
        [nc addObserver:self selector:@selector(umSwipe_receivedSwipe:) name:uniMagDidReceiveDataNotification object:nil];
        [nc addObserver:self selector:@selector(umCommand_starting:) name:uniMagCmdSendingNotification object:nil];
        [nc addObserver:self selector:@selector(umCommand_timeout:) name:uniMagCommandTimeoutNotification object:nil];
        [nc addObserver:self selector:@selector(umCommand_receivedResponse:) name:uniMagDidReceiveCmdNotification object:nil];
        [nc addObserver:self selector:@selector(umSystemMessage:) name:uniMagSystemMessageNotification object:nil];
    }
    else {
        [nc removeObserver:self];
    }
}

//called when uniMag is physically attached
- (void)umDevice_attachment:(NSNotification *)notification {
//    if (self.simSwipeUniMagIISwitch.on) {
        [self uniMag_activate];
 //   }
    
    [self displayDeviceStatus];
}

//called when uniMag is physically detached
- (void)umDevice_detachment:(NSNotification *)notification {
 //   if (!self.simSwipeUniMagIISwitch.on) {
        [self uniMag_deactivate];
 //   }
    
    [self displayDeviceStatus];
}

#pragma mark connection task

//called when attempting to start the connection task but iDevice's headphone playback volume is too low
- (void)umConnection_lowVolume:(NSNotification *)notification {
}

//called when successfully starting the connection task
- (void)umConnection_starting:(NSNotification *)notification {
}

//called when SDK failed to handshake with reader in time. ie, the connection task has timed out
- (void)umConnection_timeout:(NSNotification *)notification {
}

////called when the connection task is successful. SDK's connection state changes to true
- (void)umConnection_connected:(NSNotification *)notification {
    [self.uniMag requestSwipe];
    [self displayDeviceStatus];
}

//called when SDK's connection state changes to false. This happens when reader becomes
// physically detached or when a disconnect API is called
- (void)umConnection_disconnected:(NSNotification *)notification {
    [self displayDeviceStatus];
}

#pragma mark swipe task

//called when the swipe task is successfully starting, meaning the SDK starts to
// wait for a swipe to be made
- (void)umSwipe_starting:(NSNotification *)notification {
}

//called when the SDK hasn't received a swipe from the device within a configured
// "swipe timeout interval".
- (void)umSwipe_timeout:(NSNotification *)notification {
}

//called when the SDK has read something from the uniMag device
// (eg a swipe, a response to a command) and is in the process of decoding it
// Use this to provide an early feedback on the UI
- (void)umDataProcessing:(NSNotification *)notification {
}

//called when SDK failed to read a valid card swipe
- (void)umSwipe_invalid:(NSNotification *)notification {
    [self.uniMag requestSwipe];
}

//called when SDK received a swipe successfully
- (void)umSwipe_receivedSwipe:(NSNotification *)notification {
    
    NSData *data = [notification object];
    NSLog(@"[[ %@ ]]",[data description]);
    
    [self.uniMag requestSwipe];
    [self determineNextStep];
}

//called when SDK successfully starts to send a command. SDK starts the command
// task
- (void)umCommand_starting:(NSNotification *)notification {
}

//called when SDK failed to receive a command response within a configured
// "command timeout interval"
- (void)umCommand_timeout:(NSNotification *)notification {
}

//called when SDK successfully received a response to a command
- (void)umCommand_receivedResponse:(NSNotification *)notification {
}

- (void)determineNextStep {
    // this is where we shuttle the data
}


@end
