#ifndef LEOJSON_H
#define LEOJSON_H

#import <Foundation/Foundation.h>

typedef enum {
    LeoJSONReadStrict = 0
} LeoJSONReadOptions;

typedef enum {
    LeoJSONWriteCompact = 0
} LeoJSONWriteOptions;

/*
 * Returns an autoreleased Foundation object graph.
 *
 * Supported root objects are determined by JSONKit's parser behavior.
 * The caller does not own the returned object.
 *
 * errorString receives an autoreleased diagnostic string when provided.
 */
id LeoJSONObjectFromData(NSData *data,
                         LeoJSONReadOptions options,
                         NSString **errorString);

/*
 * Returns autoreleased JSON data.
 *
 * The caller does not own the returned data.
 *
 * errorString receives an autoreleased diagnostic string when provided.
 */
NSData *LeoJSONDataFromObject(id object,
                              LeoJSONWriteOptions options,
                              NSString **errorString);

#endif
