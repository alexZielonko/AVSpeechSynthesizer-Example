//
//  AVSpeechSynthesizerViewController.m
//  AVSpeechSynthesizerExample
//
//  Created by Alexander Zielonko on 12/16/13.
//  Copyright (c) 2013 Alexander Zielonko. All rights reserved.
//

#import "AVSpeechSynthesizerViewController.h"

@interface AVSpeechSynthesizerViewController ()

@property (assign) BOOL siriDidUtter;

@end

@implementation AVSpeechSynthesizerViewController

//
// Be sure to #import <AVFoundation/AVFoundation.h> and #import <AudioToolbox/AudioToolbox.h> in your .h file
//
- (void)sendSoundNotification
{
    if (_siriDidUtter == NO) {
        // Create AVAudioSession with DuckOthers option
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback
                      withOptions:AVAudioSessionCategoryOptionDuckOthers
                            error:nil];
        [audioSession setActive:YES error:nil];
        
        // Create the Speech Synthesizer and Utterance
        AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc]init];
        AVSpeechUtterance *utterance = [AVSpeechUtterance
                                        speechUtteranceWithString:@"Hello friend. Please, take a moment to appreciate my beautiful voice"];
        
        // Create timer with time interval appropriate for utterance
        // Calls targetMethod after 4.0 seconds
        [NSTimer scheduledTimerWithTimeInterval:4.0
                                        target:self
                                        selector:@selector(targetMethod)
                                        userInfo:nil
                                        repeats:NO];
        // Play utterance, setRate:-1.0 is very slow, setRate:1.0 is quite fast
        [utterance setRate:0.15f];
        [synthesizer speakUtterance:utterance];
        
        // AVSpeechBoundary could also be used to prevent the utterance from repeating
        _siriDidUtter = YES;
        }
}

- (void)targetMethod
{
    [[AVAudioSession sharedInstance] setActive:NO
                                     withFlags:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation  error:nil];
    NSLog(@"Audio volume of other applications should now return to previous value");
}

@end
