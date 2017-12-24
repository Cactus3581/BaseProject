//
//  UIControl+Sound.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "UIControl+BPSound.h"
#import <objc/runtime.h>

// Key for the dictionary of sounds for control events.
static char const * const bp_kSoundsKey = "bp_kSoundsKey";

@implementation UIControl (BPSound)

- (void)bp_setSoundNamed:(NSString *)name forControlEvent:(UIControlEvents)controlEvent
{
	// Remove the old UI sound.
	NSString *oldSoundKey = [NSString stringWithFormat:@"%zd", controlEvent];
	AVAudioPlayer *oldSound = [self bp_sounds][oldSoundKey];
	[self removeTarget:oldSound action:@selector(play) forControlEvents:controlEvent];
	
	// Set appropriate category for UI sounds.
	// Do not mute other playing audio.
    [[AVAudioSession sharedInstance] setCategory:@"AVAudioSessionCategoryAmbient" error:nil];
	
	// Find the sound file.
    NSString *file = [name stringByDeletingPathExtension];
    NSString *extension = [name pathExtension];
    NSURL *soundFileURL = [[NSBundle mainBundle] URLForResource:file withExtension:extension];
	
    NSError *error = nil;
	
	// Create and prepare the sound.
	AVAudioPlayer *tapSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
	NSString *controlEventKey = [NSString stringWithFormat:@"%zd", controlEvent];
	NSMutableDictionary *sounds = [self bp_sounds];
	[sounds setObject:tapSound forKey:controlEventKey];
	[tapSound prepareToPlay];
	if (!tapSound) {
		BPLog(@"Couldn't add sound - error: %@", error);
		return;
	}
	
	// Play the sound for the control event.
	[self addTarget:tapSound action:@selector(play) forControlEvents:controlEvent];
}


#pragma mark - Associated objects setters/getters

- (void)setBp_sounds:(NSMutableDictionary *)sounds
{
	objc_setAssociatedObject(self, bp_kSoundsKey, sounds, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)bp_sounds
{
	NSMutableDictionary *sounds = objc_getAssociatedObject(self, bp_kSoundsKey);
	
	// If sounds is not yet created, create it.
	if (!sounds) {
		sounds = [[NSMutableDictionary alloc] initWithCapacity:2];
		// Save it for later.
		[self setBp_sounds:sounds];
	}
	
	return sounds;
}

@end
