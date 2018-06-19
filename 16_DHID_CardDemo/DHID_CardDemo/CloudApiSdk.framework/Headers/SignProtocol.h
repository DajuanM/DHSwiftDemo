/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */


#import <Foundation/Foundation.h>

@protocol SignProtocol <NSObject>

- (NSString *)signMethod;

- (NSString *)appKey;

/**
 *  签名方法
 *  本方法将Request中的httpMethod、headers、path、queryParam、formParam合成一个字符串用hmacSha256算法双向加密进行签名
 */
- (NSString *)signWithData:(NSString *)data;

@end
