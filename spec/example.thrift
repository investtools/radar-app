enum Gender {
  MALE, FEMALE
}

struct PhoneNumber {
  1: string contry_code
  2: string area_code
  3: string number
}

struct Person {
  1: string name
  2: PhoneNumber phone
  3: list<Person> children
  4: list<string> notes
  5: Gender gender
  6: i32 age
  7: set<i32> favorite_numbers
}
