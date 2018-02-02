(ns name-normalizer.core-test
  (:require [clojure.test :refer :all]
            [name-normalizer.core :refer :all]))

(deftest a-name-normalizer
  #_(testing "returns empty string when passed an empty string"
    (is (= "" (normalize ""))))
  #_(testing "returns single word name"
    (is (= "Plato" (normalize "Plato"))))
  #_(testing "swapsFirstAndLastNames"
    (is (= "Murakami, Haruki" (normalize "Haruki Murakami"))))
  #_(testing "trimsLeadingAndTrailingWhitespace"
    (is (= "Boi, Big" (normalize "   Big Boi   "))))
  #_(testing "initializesMiddleName"
    (is (= "Thoreau, Henry D." (normalize "Henry David Thoreau"))))
  #_(testing "doesNotInitializeOneLetterMiddleName"
    (is (= "Truman, Harry S" (normalize "Harry S Truman"))))
  #_(testing "initializesEachOfMultipleMiddleNames"
    (is (= "Louis-Dreyfus, Julia S. E." (normalize "Julia Scarlett Elizabeth Louis-Dreyfus"))))
  #_(testing "appendsSuffixesToEnd"
    (is (= "King, Martin L., Jr." (normalize "Martin Luther King, Jr."))))
  #_(testing "throwsWhenNameContainsTwoCommas"
    (is (thrown? IllegalArgumentException (normalize "Thurston, Howell, III")))))
