//
//  GPDateUtils.m
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/03.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import "GPDateUtils.h"

@implementation GPDateUtils

+ (NSDate *) dateWithDateTimeString:(NSString *)dateTimeString {

    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];

    [dateFormatter setCalendar:[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease]];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

    return [dateFormatter dateFromString:dateTimeString];

}

@end
