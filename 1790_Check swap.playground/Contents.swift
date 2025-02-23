 

 
func areAlmostEqual(_ s1: String, _ s2: String) -> Bool {
    if s1 == s2 { return true }
    
    var s1 = Array(s1)
    var s2 = Array(s2)
    var mismatches = [Int]()
    
    
    for i in 0..<s2.count {
        if s1[i] != s2[i] {
            mismatches.append(i)
            if mismatches.count > 2 {
                return false
            }
        }
    }
    
    if mismatches.count == 2 {
        let temp = s2[mismatches[0]]
        s2[mismatches[0]] = s2[mismatches[1]]
        s2[mismatches[1]] = temp
        
    }
    return s2 == s1
}
areAlmostEqual("qgqeg", "gqgeq")
