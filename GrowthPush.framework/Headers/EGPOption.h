//
//  EGPOptionTag.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/09/20.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS (NSInteger, EGPOption) {
    EGPOptionNone = 0,
    EGPOptionTrackLaunch = 1 << 0,
    EGPOptionTagDevie = 1 << 1,
    EGPOptionTagOS = 1 << 2,
    EGPOptionTagLanguage = 1 << 3,
    EGPOptionTagTimeZone = 1 << 4,
    EGPOptionTagVersion = 1 << 5,
    EGPOptionTagBuild = 1 << 6,
    EGPOptionTrackAll = EGPOptionTrackLaunch,
    EGPOptionTagAll = EGPOptionTagDevie | EGPOptionTagOS | EGPOptionTagLanguage | EGPOptionTagTimeZone | EGPOptionTagVersion | EGPOptionTagBuild,
    EGPOptionAll = EGPOptionTrackAll | EGPOptionTagAll,
};