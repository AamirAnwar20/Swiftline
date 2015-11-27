//
//  ArgsParser.swift
//  Swiftline
//
//  Created by Omar Abdelhafith on 27/11/2015.
//  Copyright © 2015 Omar Abdelhafith. All rights reserved.
//

class ArgsParser {
  
  static func parseFlags(args: [String]) -> ([Option], [String]) {
    var options = [Option]()
    var others = [String]()
    var previousArgument: Argument?
    
    for argumentString in args {
      let argument = Argument(argumentString)
      defer { previousArgument = argument }
      
      if argument.isFlag {
        options += [Option(argument: argument)]
        continue
      }
      
      if let previousArgument = previousArgument where previousArgument.isFlag {
        updatelastOption(forArray: &options, withValue: argumentString)
      } else {
        others += [argument.name]
      }
    }
    
    return (options, others)
    
  }
  
  static func updatelastOption(inout forArray array: [Option], withValue value: String) {
    var previousOption = array.last!
    previousOption.value = value
    array.removeLast()
    array += [previousOption]
  }
}
