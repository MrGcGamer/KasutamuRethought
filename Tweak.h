#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/NSUserDefaults+Private.h>

#ifdef DEBUG
#define __FILENAME__ (strrchr(__FILE__, '/') ? strrchr(__FILE__, '/') + 1 : __FILE__)
#define GCLog(fmt, ...) do {NSLog((@"[KasutamuRethought] - [%s:%d]: " fmt), __FILENAME__, __LINE__, ##__VA_ARGS__);} while(0)
#else
#define GCLog(...)
#endif

@interface CHSWidget : NSObject
@property (nonatomic,copy,readonly) NSString * extensionBundleIdentifier;
@end

@interface CHUISWidgetHostViewController : UIViewController
@property (nonatomic,copy) CHSWidget * widget;
@end
@interface SBHWidgetViewController : CHUISWidgetHostViewController
@end

@protocol SBLeafIconDataSource <NSObject>
@optional
@property (nonatomic,copy,readonly) NSString * uniqueIdentifier;
@property (nonatomic,copy,readonly) NSString * configurationStorageIdentifier;
@end

@interface SBHWidgetStackViewController : UIViewController
@property (nonatomic,retain) id<SBLeafIconDataSource> activeWidget;
@property (assign,nonatomic) unsigned long long widgetScaleAnimationCount;
@property (assign,nonatomic) unsigned long long backgroundAnimationCount;
@end