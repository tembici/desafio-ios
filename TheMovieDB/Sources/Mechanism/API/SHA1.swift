//
//  SHA.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

infix operator <<< : BitwiseShiftPrecedence

func <<< (lhs: UInt32, rhs: UInt32) -> UInt32 {
    return lhs << rhs | lhs >> (32 - rhs)
}

// swiftlint:disable identifier_name
struct SHA1 {
    private static let CHUNKSIZE = 80
    
    private static let h0: UInt32 = 0x67452301
    private static let h1: UInt32 = 0xEFCDAB89
    private static let h2: UInt32 = 0x98BADCFE
    private static let h3: UInt32 = 0x10325476
    private static let h4: UInt32 = 0xC3D2E1F0
    
    private struct Context {
        var h: [UInt32] = [SHA1.h0, SHA1.h1, SHA1.h2, SHA1.h3, SHA1.h4]
        
        mutating func process(chunk: inout ContiguousArray<UInt32>) {
            for i in 0..<16 {
                chunk[i] = chunk[i].bigEndian
            }
            
            for i in 16...79 {
                chunk[i] = (chunk[i-3] ^ chunk[i-8] ^ chunk[i-14] ^ chunk[i-16]) <<< 1
            }
            
            var a, b, c, d, e, f, k, temp: UInt32
            
            a = h[0]
            b = h[1]
            c = h[2]
            d = h[3]
            e = h[4]
            
            f = 0x0
            k = 0x0
            
            for i in 0...79 {
                switch i {
                case 0...19:
                    f = (b & c) | ((~b) & d)
                    k = 0x5A827999
                    
                case 20...39:
                    f = b ^ c ^ d
                    k = 0x6ED9EBA1
                    
                case 40...59:
                    f = (b & c) | (b & d) | (c & d)
                    k = 0x8F1BBCDC
                    
                case 60...79:
                    f = b ^ c ^ d
                    k = 0xCA62C1D6
                    
                default: break
                }
                
                temp = a <<< 5 &+ f &+ e &+ k &+ chunk[i]
                e = d
                d = c
                c = b <<< 30
                b = a
                a = temp
            }
            
            h[0] = h[0] &+ a
            h[1] = h[1] &+ b
            h[2] = h[2] &+ c
            h[3] = h[3] &+ d
            h[4] = h[4] &+ e
        }
    }
    
    private static func process(data: inout Data) -> SHA1.Context? {
        var context = SHA1.Context()
        var w = ContiguousArray<UInt32>(repeating: 0x00000000, count: CHUNKSIZE)
        var range = 0..<64
        
        let ml = data.count << 3
        
        while data.count >= range.upperBound {
            w.withUnsafeMutableBufferPointer { dest in
                _ = data.copyBytes(to: dest, from: range)
            }
            
            context.process(chunk: &w)
            range = range.upperBound..<range.upperBound+64
        }
        
        w = ContiguousArray<UInt32>(repeating: 0x00000000, count: CHUNKSIZE)
        range = range.lowerBound..<data.count
        
        w.withUnsafeMutableBufferPointer { dest in
            _ = data.copyBytes(to: dest, from: range)
        }
        
        let bytetochange = range.count % 4
        let shift = UInt32(bytetochange * 8)
        
        w[range.count / 4] |= 0x80 << shift
        
        if range.count + 1 > 56 {
            context.process(chunk: &w)
            w = ContiguousArray<UInt32>(repeating: 0x00000000, count: CHUNKSIZE)
        }
        
        w[15] = UInt32(ml).bigEndian
        context.process(chunk: &w)
        
        return context
    }
    
    static func from(string: String) -> String? {
        guard var data = string.data(using: .utf8), let context = SHA1.process(data: &data) else {
            return nil
        }
        
        return String(format: "%08X-%08X-%08X-%08X-%08X", context.h[0], context.h[1], context.h[2], context.h[3], context.h[4])
    }
    
}
