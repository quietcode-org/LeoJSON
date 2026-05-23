#ifndef LEOJSON_KIT_ENGINE_H
#define LEOJSON_KIT_ENGINE_H

#import <Foundation/Foundation.h>

id LeoJSONKitEngineObjectFromData(NSData *data, NSString **errorString);
NSData *LeoJSONKitEngineDataFromObject(id object, NSString **errorString);

#endif

