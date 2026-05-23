#ifndef LEOJSON_H
#define LEOJSON_H

#import <Foundation/Foundation.h>
#import "LeoJSONVersion.h"

/*!
 @header LeoJSON
 @abstract Leopard-Crew JSON boundary for Mac OS X 10.5.8 PowerPC.
 @discussion
 LeoJSON provides the public JSON API boundary for Leopard-Crew projects.

 JSONKit remains an internal parser and serializer engine. Application code
 should include LeoJSON.h and must not include JSONKit.h directly.

 LeoJSON follows Cocoa naming and ownership conventions. Returned objects are
 autoreleased unless otherwise documented.
 */

/*!
 @enum LeoJSONReadOptions
 @abstract Options controlling JSON parsing.
 @constant LeoJSONReadStrict Strict JSON parsing. This is currently the only
 supported read option.
 */
typedef enum {
    LeoJSONReadStrict = 0
} LeoJSONReadOptions;

/*!
 @enum LeoJSONWriteOptions
 @abstract Options controlling JSON serialization.
 @constant LeoJSONWriteCompact Compact JSON output. This is currently the only
 supported write option.
 */
typedef enum {
    LeoJSONWriteCompact = 0
} LeoJSONWriteOptions;

/*!
 @function LeoJSONObjectFromData
 @abstract Parses UTF-8 JSON data into Foundation objects.
 @param data The JSON data to parse. Must not be nil.
 @param options JSON read options. Currently only LeoJSONReadStrict is supported.
 @param errorString Optional output pointer receiving an autoreleased diagnostic
 string on failure. May be NULL.
 @result An autoreleased Foundation object graph, or nil on failure.
 @discussion
 The caller does not own the returned object. Retain or copy it if it must live
 beyond the current autorelease pool.

 If parsing fails and errorString is not NULL, LeoJSON stores an autoreleased
 diagnostic string in *errorString. Diagnostic strings are intended for logging
 and developer feedback, not as stable machine-readable error codes.
 */
id LeoJSONObjectFromData(NSData *data,
                         LeoJSONReadOptions options,
                         NSString **errorString);

/*!
 @function LeoJSONDataFromObject
 @abstract Serializes a Foundation object graph to compact UTF-8 JSON data.
 @param object The Foundation object graph to serialize. Must not be nil.
 @param options JSON write options. Currently only LeoJSONWriteCompact is
 supported.
 @param errorString Optional output pointer receiving an autoreleased diagnostic
 string on failure. May be NULL.
 @result Autoreleased JSON data, or nil on failure.
 @discussion
 The caller does not own the returned data. Retain or copy it if it must live
 beyond the current autorelease pool.

 The supported Foundation object graph follows LeoJSON's current API contract
 and the vendored JSONKit engine behind the LeoJSON boundary.
 */
NSData *LeoJSONDataFromObject(id object,
                              LeoJSONWriteOptions options,
                              NSString **errorString);

#endif
