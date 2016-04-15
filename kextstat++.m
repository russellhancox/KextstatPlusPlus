/**
 *  kextstat++
 *  A more useful kextstat if you want lots of info about a single kext.
 *
 *  Usage: kextstat bundle-id <wanted-key>
 *  E.g:   kextstat com.apple.driver.ApplePlatformEnabler
 *         kextstat com.apple.driver.ApplePlatformEnabler OSBundleLoadAddress
 */

#import <Foundation/Foundation.h>
#import <IOKit/kext/KextManager.h>

#include <libgen.h>
#include <mach-o/arch.h>

void PrintDictionary(NSDictionary *dict, NSString *wantedKey) {
  [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSObject *obj, BOOL *stop) {
      const char *value = "";

      if ([key isEqual:@"OSBundleLoadAddress"]) {
        unsigned long long v = [(NSNumber *)obj unsignedLongLongValue];
        NSString *str = [NSString stringWithFormat:@"0x%016llx", v];
        value = str.UTF8String;
      } else if ([key isEqual:@"OSBundleUUID"]) {
        NSUUID *uuid = [[NSUUID alloc] initWithUUIDBytes:[(NSData *)obj bytes]];
        value = uuid.UUIDString.UTF8String;
      } else if ([key isEqual:@"OSBundleCPUType"]) {
        int cputype = [(NSNumber *)obj intValue];
        const NXArchInfo *archInfo = NXGetArchInfoFromCpuType(cputype, CPU_SUBTYPE_MULTIPLE);
        NSString *s = [NSString stringWithFormat:@"%d (%s)", cputype, archInfo->description];
        value = s.UTF8String;
      } else if ([key isEqual:@"OSBundleIsInterface"] ||
                 [key isEqual:@"OSBundlePrelinked"] ||
                 [key isEqual:@"OSBundleStarted"] ||
                 [key isEqual:@"OSKernelResource"]) {
        NSString *s = ([(NSNumber *)obj boolValue]) ? @"YES" : @"NO";
        value = s.UTF8String;
      } else {
        value = obj.description.UTF8String;
      }

      if (!wantedKey || [wantedKey caseInsensitiveCompare:key] == NSOrderedSame) {
        printf("%s = %s\n", key.UTF8String, value);
      }
  }];
}

int main(int argc, char *argv[]) {
  @autoreleasepool {
    if (argc < 2) {
      printf("Usage: %s bundle-id <wanted-key>\n", basename(argv[0]));
      exit(1);
    }

    NSString *bundleID = @(argv[1]);
    NSString *wantedKey;
    if (argc > 2) wantedKey = @(argv[2]);

    NSDictionary *data = CFBridgingRelease(KextManagerCopyLoadedKextInfo(
        (__bridge CFArrayRef)@[ bundleID ], NULL));
    data = data[bundleID];

    if (!data) {
      printf("Kext with bundle-id [%s] is not loaded\n", bundleID.UTF8String);
    } else {
      PrintDictionary(data, wantedKey);
    }
  }
}
