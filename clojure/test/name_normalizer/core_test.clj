(ns name-normalizer.core-test
  (:require [clojure.test :refer :all]
            [name-normalizer.core :refer :all]))

(deftest a-name-normalizer
  #_(testing "returns empty string when passed an empty string"
    (is (= "" (normalize ""))))
  #_(testing "returns single word name"
    (is (= "Plato" (normalize "Plato"))))
  #_(testing "swaps first and last names"
    (is (= "Murakami, Haruki" (normalize "Haruki Murakami"))))
  #_(testing "trims leading and trailing whitespace"
    (is (= "Boi, Big" (normalize "   Big Boi   "))))
  #_(testing "initializes middle name"
    (is (= "Thoreau, Henry D." (normalize "Henry David Thoreau"))))
  #_(testing "does not initialize one letter middle name"
    (is (= "Truman, Harry S" (normalize "Harry S Truman"))))
  #_(testing "initializes each of multiple middle names"
    (is (= "Louis-Dreyfus, Julia S. E." (normalize "Julia Scarlett Elizabeth Louis-Dreyfus"))))
  #_(testing "appends suffixes to end"
    (is (= "King, Martin L., Jr." (normalize "Martin Luther King, Jr."))))
  #_(testing "throws when name contains two commas"
    (is (thrown? IllegalArgumentException (normalize "Thurston, Howell, III")))))
