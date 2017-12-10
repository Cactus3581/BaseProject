//
//  NSData+BPPCM.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
/*
 
AudioStreamBasicDescription _format;
_format.mFormatID = kAudioFormatLinearPCM;
_format.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
_format.mBitsPerChannel = 16;
_format.mChannelsPerFrame = 1;
_format.mBytesPerPacket = _format.mBytesPerFrame = (_format.mBitsPerChannel / 8) * _format.mChannelsPerFrame;
_format.mFramesPerPacket = 1;
_format.mSampleRate = 8000.0f;
*/

@interface NSData (BPPCM)
/**
 *  format wav data
 *
 *  @param self   raw audio data
 *  @param PCMFormat format of pcm
 *
 *  @return wav data
 */
- (NSData *)_wavDataWithPCMFormat:(AudioStreamBasicDescription)PCMFormat;
@end
