var seed: UInt32 = 12345

func simpleRandom() -> UInt32 {
    seed = (1664525 &* seed &+ 1013904223) % UInt32.max
    return seed
}

func customRandom(in range: Range<Int>) -> Int {
    let lowerBound = UInt32(range.lowerBound)
    let upperBound = UInt32(range.upperBound)
    return Int(lowerBound + simpleRandom() % (upperBound - lowerBound))
}

 
let randomNumber = customRandom(in: 1..<100)
print(randomNumber)  

