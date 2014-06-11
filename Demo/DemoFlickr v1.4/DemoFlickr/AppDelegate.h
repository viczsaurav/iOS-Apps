//
//  AppDelegate.h
//  DemoFlickr
//
//  Created by Ouh Eng Lieh on 4/1/14.
//  Copyright (c) 2014 Ouh Eng LIeh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    AVAudioPlayer *audioPlayer;
}

@property (strong, nonatomic) UIWindow *window;

@end
