/*
 Given two strings s and t, determine if they are isomorphic.

 Two strings s and t are isomorphic if the characters in s can be replaced to get t.

 All occurrences of a character must be replaced with another character while preserving the order of characters. No two characters may map to the same character, but a character may map to itself.
 
 Input: s = "egg", t = "add"

 Output: true

 Explanation:

 The strings s and t can be made identical by:

 Mapping 'e' to 'a'.
 Mapping 'g' to 'd'.

 
 Input: s = "foo", t = "bar"

 Output: false

 Explanation:

 The strings s and t can not be made identical as 'o' needs to be mapped to both 'a' and 'r'.
 
 
 Input: s = "paper", t = "title"

 Output: true

 Мы должны сделать словарь, key это текущей элемент s, value это текущий элемент T

 */


func isIsomorphic(_ s: String, _ t: String) -> Bool {
   
    guard s.count == t.count else {
        return false
    }
    
    //нужно завести 2 словаря
    var sToTMapping: [Character: Character] = [:]
    var tToSMapping: [Character: Character] = [:]
    
    for (charS, charT) in zip(s, t) {
        
        if let mappedChar = sToTMapping[charS] {
            if mappedChar != charT {
                return false
            }
        } else {
            sToTMapping[charS] = charT
        }
         
        if let mappedChar = tToSMapping[charT] {
            if mappedChar != charS {
                return false
            }
        } else {
            tToSMapping[charT] = charS
        }
    }
    
    return true
}

 
print(isIsomorphic("egg", "add"))
print(isIsomorphic("foo", "bar"))
print(isIsomorphic("paper", "title"))
print(isIsomorphic("badc", "baba"))
