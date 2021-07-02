/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "SDWebImageCompat.h"

// image cache 过期类型
typedef NS_ENUM(NSUInteger, SDImageCacheConfigExpireType) {
    // 访问，触发更新
    SDImageCacheConfigExpireTypeAccessDate,
    // 创建、修改，触发更新（默认）
    SDImageCacheConfigExpireTypeModificationDate,
    // 创建，触发更新
    SDImageCacheConfigExpireTypeCreationDate,
    // 创建、修改、重命名、更新文件属性（比如 permission、xattr），触发更新
    SDImageCacheConfigExpireTypeChangeDate,
};

/**
 The class contains all the config for image cache
 @note This class conform to NSCopying, make sure to add the property in `copyWithZone:` as well.
 */
@interface SDImageCacheConfig : NSObject <NSCopying>

/**
 Gets the default cache config used for shared instance or initialization when it does not provide any cache config. Such as `SDImageCache.sharedImageCache`.
 @note You can modify the property on default cache config, which can be used for later created cache instance. The already created cache instance does not get affected.
 */
@property (nonatomic, class, readonly, nonnull) SDImageCacheConfig *defaultCacheConfig;

/**
 * Whether or not to disable iCloud backup
 * Defaults to YES.
 */
@property (assign, nonatomic) BOOL shouldDisableiCloud;

// 是否使用 memory cache，默认为 YES
@property (assign, nonatomic) BOOL shouldCacheImagesInMemory;

/*
 * The option to control weak memory cache for images. When enable, `SDImageCache`'s memory cache will use a weak maptable to store the image at the same time when it stored to memory, and get removed at the same time.
 * However when memory warning is triggered, since the weak maptable does not hold a strong reference to image instance, even when the memory cache itself is purged, some images which are held strongly by UIImageViews or other live instances can be recovered again, to avoid later re-query from disk cache or network. This may be helpful for the case, for example, when app enter background and memory is purged, cause cell flashing after re-enter foreground.
 * Defaults to YES. You can change this option dynamically.
 */
@property (assign, nonatomic) BOOL shouldUseWeakMemoryCache;

/**
 * Whether or not to remove the expired disk data when application entering the background. (Not works for macOS)
 * Defaults to YES.
 */
@property (assign, nonatomic) BOOL shouldRemoveExpiredDataWhenEnterBackground;

/**
 * Whether or not to remove the expired disk data when application been terminated. This operation is processed in sync to ensure clean up.
 * Defaults to YES.
 */
@property (assign, nonatomic) BOOL shouldRemoveExpiredDataWhenTerminate;

/**
 * The reading options while reading cache from disk.
 * Defaults to 0. You can set this to `NSDataReadingMappedIfSafe` to improve performance.
 */
@property (assign, nonatomic) NSDataReadingOptions diskCacheReadingOptions;

/**
 * The writing options while writing cache to disk.
 * Defaults to `NSDataWritingAtomic`. You can set this to `NSDataWritingWithoutOverwriting` to prevent overwriting an existing file.
 */
@property (assign, nonatomic) NSDataWritingOptions diskCacheWritingOptions;

// image 保留在磁盘缓存中的最长时间（秒）
// Setting this to a negative value means no expiring.
// Setting this to zero means that all cached files would be removed when do expiration check.
// 默认为一周
@property (assign, nonatomic) NSTimeInterval maxDiskAge;

// 磁盘缓存的最大 size（字节）
// 默认为 0，这意味着没有缓存大小限制
@property (assign, nonatomic) NSUInteger maxDiskSize;

// 内存中 image 缓存的最大总开销（字节）
// @note The memory cost is bytes size in memory, but not simple pixels count. For common ARGB8888 image, one pixel is 4 bytes (32 bits).
// 默认为 0。这意味着没有内存开销限制
@property (assign, nonatomic) NSUInteger maxMemoryCost;

// 内存中 image 缓存的最大数量
// 默认为 0。这意味着没有内存数量限制
@property (assign, nonatomic) NSUInteger maxMemoryCount;

// 清除磁盘缓存时，将根据其检查清除缓存的属性
// 默认为修改日期
@property (assign, nonatomic) SDImageCacheConfigExpireType diskCacheExpireType;

/**
 * The custom file manager for disk cache. Pass nil to let disk cache choose the proper file manager.
 * Defaults to nil.
 * @note This value does not support dynamic changes. Which means further modification on this value after cache initialized has no effect.
 * @note Since `NSFileManager` does not support `NSCopying`. We just pass this by reference during copying. So it's not recommend to set this value on `defaultCacheConfig`.
 */
@property (strong, nonatomic, nullable) NSFileManager *fileManager;

/**
 * The custom memory cache class. Provided class instance must conform to `SDMemoryCache` protocol to allow usage.
 * Defaults to built-in `SDMemoryCache` class.
 * @note This value does not support dynamic changes. Which means further modification on this value after cache initialized has no effect.
 */
@property (assign, nonatomic, nonnull) Class memoryCacheClass;

/**
 * The custom disk cache class. Provided class instance must conform to `SDDiskCache` protocol to allow usage.
 * Defaults to built-in `SDDiskCache` class.
 * @note This value does not support dynamic changes. Which means further modification on this value after cache initialized has no effect.
 */
@property (assign ,nonatomic, nonnull) Class diskCacheClass;

@end
