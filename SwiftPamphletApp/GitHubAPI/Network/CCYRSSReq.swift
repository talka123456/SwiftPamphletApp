//
//  CCYReq.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/20.
//

import Foundation

func RSSReq(_ urlStr: String) async throws -> String? {
    // swift 中 会大量使用 guard 关键词做提前退出
    guard let url = URL(string: urlStr) else {
        fatalError("wrong url")
    }
    let req = URLRequest(url: url)
    // async + 元组应用
    let (data, res) = try await URLSession.shared.data(for: req)
    // 校验响应码
    guard (res as? HTTPURLResponse)?.statusCode == 200 else {
        return ""
    }
    let dataStr = String(data: data, encoding: .utf8)
    return dataStr
}

/// 仿写
/// 对于 guard 的用法可以参考 SwiftGG [使用 guard 的正确姿势](https://swift.gg/2016/02/14/swift-guard-radix/)
func HWRSSReq(_ urlStr: String) async throws -> String? {
    
    // guard 语法中 condition 为 ture 继续执行，否则执行 else {}
    
    guard let url = URL(string: urlStr) else {
        fatalError("wrong url")
    }
    
    // 相比 if 的好处是，条件变量是可以继续在后续作用域使用的， if 定义的变量则不可以
    let req = URLRequest(url: url)
    
    // 使用元组作为返回值， async 语法调用
    URLSession.shared.dataTask(with: url) { data, res, error in
        print("load end")
    };
    
    print("End")
    
    let (data, res) = try await URLSession.shared.data(for: req)
    print("End2")
    
    // 校验响应码
    guard (res as? HTTPURLResponse)?.statusCode == 200 else {
        return ""
    }
    
    let dataStr = String(data: data, encoding: .utf8)
    return dataStr
}
