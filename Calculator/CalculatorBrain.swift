//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Danyao Wang on 5/20/17.
//  Copyright © 2017 Danyao Wang. All rights reserved.
//

import Foundation

struct CalculatorBrain {
  private struct PendingBinaryOperation {
    var function: (Double, Double) -> Double
    var firstOperand: Double
  }
  
  private enum Operation {
    case Constant(Double)
    case UnaryOperator((Double) -> Double)
    case BinaryOperator((Double, Double) -> Double)
    case Equals
  }
  
  private var accumulator: Double? = nil
  private var pendingBinaryOperation: PendingBinaryOperation? = nil
  
  private var operations: Dictionary<String, Operation> = [
    "π": .Constant(Double.pi),
    "e": .Constant(M_E),
    "√": .UnaryOperator(sqrt),
    "cos": .UnaryOperator(cos),
    "±": .UnaryOperator({ -$0 }),
    "+": .BinaryOperator({ $0 + $1 }),
    "-": .BinaryOperator({ $0 - $1 }),
    "×": .BinaryOperator({ $0 * $1 }),
    "÷": .BinaryOperator({ $0 / $1 }),
    "=": .Equals
  ]
  
  var result: Double? {
    get {
      return accumulator
    }
  }
  
  mutating func setOperand(_ operand: Double) {
    accumulator = operand
  }
  
  mutating func performOperation(_ symbol: String) {
    if let operation = operations[symbol] {
      switch(operation) {
      case .Constant(let value):
        accumulator = value
      case .UnaryOperator(let function):
        if let operand = accumulator {
          accumulator = function(operand)
        }
      case .BinaryOperator(let binaryFunction):
        if let operand = accumulator {
          pendingBinaryOperation = PendingBinaryOperation(
            function: binaryFunction, firstOperand: operand)
          accumulator = nil
        }
      case .Equals:
        performBinaryOperation()
      }
    }
  }
  
  private mutating func performBinaryOperation() {
    if accumulator != nil && pendingBinaryOperation != nil {
      accumulator = pendingBinaryOperation!.function(
        pendingBinaryOperation!.firstOperand, accumulator!)
      pendingBinaryOperation = nil
    }
  }
}
