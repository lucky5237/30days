//
//  JMVoiceBubbleContentView.m
//  JMessageOCDemo
//
//  Created by oshumini on 2017/6/14.
//  Copyright © 2017年 HXHG. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "JMVoiceBubbleContentView.h"
#import "MessageModel.h"
#import "MySocialApp-Swift.h"

@interface JMVoiceBubbleContentView ()
@property(strong, nonatomic)UIImageView *voiceImg;
@property(weak, nonatomic)MessageModel *messageModel;
@property(assign, nonatomic)BOOL isMediaActivity;
@end

@implementation JMVoiceBubbleContentView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _voiceImg = [UIImageView new];
    [self addSubview: _voiceImg];
    _isMediaActivity = NO;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapVoiceContents)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapGesture];
  }
  return self;
}

- (void)layoutContentViewWithMessage:(id <IMUIMessageModelProtocol> _Nonnull)message {
  _messageModel = (MessageModel *)message;
  _voiceImg.frame = CGRectMake(0, 0, 12, 16);

  if (message.isOutGoing) {
    _voiceImg.image = [UIImage imageNamed:@"outgoing_voice_3"];
    _voiceImg.center = CGPointMake(_messageModel.layout.bubbleContentSize.width - 20,
                                   _messageModel.layout.bubbleContentSize.height/2);
  } else {
    _voiceImg.image = [UIImage imageNamed:@"incoming_voice_3"];
    _voiceImg.center = CGPointMake(20,
                                   _messageModel.layout.bubbleContentSize.height/2);
  }
}

- (void)onTapVoiceContents {
  if (!_isMediaActivity) {
      __weak __typeof(self)weakSelf = self;
      [_messageModel getMediaDataCallback:^(NSData *data, NSString *msgId) {
          __strong __typeof(weakSelf)strongSelf = weakSelf;
          if ([strongSelf.messageModel.msgId isEqualToString:msgId]) {
              
              [IMUIAudioPlayerHelper.sharedInstance playAudioWithDataWithIdentify:@"" voiceData:data progressCallback:^(NSString * _Nonnull identify,float averagePower, NSTimeInterval currentTime, NSTimeInterval duration) {
                  
              } finishCallBack:^(NSString * _Nonnull identify) {
                  strongSelf.isMediaActivity = NO;
              } stopCallBack:^(NSString * _Nonnull identify) {
                  
              }];
          }
      }];
  } else {
      [IMUIAudioPlayerHelper.sharedInstance stopAudio];
  }
  
  _isMediaActivity = !_isMediaActivity;
}
@end
