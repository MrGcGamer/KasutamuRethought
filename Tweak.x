#import "Tweak.h"

static NSString *nsDomainString = @"com.mrgcgamer.kasutamurethoughtprefs";
static NSString *nsNotificationString = @"com.mrgcgamer.kasutamurethoughtprefs/ReloadPrefs";
static NSUserDefaults *prefs;
static BOOL (^boolForKey)(NSString *, BOOL);
static BOOL enabled;
static BOOL hideBlankWidget;

%hook SBHWidgetStackViewController
-(void)_setPageControlHidden:(BOOL)hidden animated:(BOOL)arg2 {
	NSString *bundleID = nil;
	if ([self.activeWidget respondsToSelector:@selector(configurationStorageIdentifier)])
		bundleID = self.activeWidget.configurationStorageIdentifier;

	if (!enabled || !hideBlankWidget || hidden || ![bundleID isEqualToString:@"com.sergheiPetcoglo.TransparentWidget"])
		%orig;

}
%end

static BOOL isWanted(SBHWidgetViewController *controller) {
	NSString *bundleID = controller.widget.extensionBundleIdentifier;
	return [bundleID isEqualToString:@"com.sergheiPetcoglo.TransparentWidget.WidgetView"];
}
%hook SBHWidgetViewController
- (id)view {
	id view = %orig;

	if (enabled && hideBlankWidget && isWanted(self)) [view setHidden:YES];

	return view;
}
%end

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	enabled = boolForKey(@"enabled", YES);
	hideBlankWidget = boolForKey(@"hideBlankWidget", YES);
}

%ctor {
	GCLog(@"Loaded KasutamuRethought");
	prefs = [[NSUserDefaults alloc] initWithSuiteName:nsDomainString];
	boolForKey = ^BOOL(NSString *key, BOOL def) {
		BOOL ret = ([prefs objectForKey:key]) ? [prefs boolForKey:key] : def;
		GCLog(@"%@: %d", key, ret);
		return ret;
	};

	// Set variables on start up
	notificationCallback(NULL, NULL, NULL, NULL, NULL);

	// Register for 'PostNotification' notifications
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, notificationCallback, (CFStringRef)nsNotificationString, NULL, CFNotificationSuspensionBehaviorCoalesce);
}