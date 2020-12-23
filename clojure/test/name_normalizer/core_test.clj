(ns name-normalizer.core-test
  (:require [clojure.test :refer :all]
            [name-normalizer.core :refer :all]))

(deftest a-name-normalizer
  (testing "returns empty string when passed an empty string"
    (is (= "" (normalize ""))))
  (testing "returns single word name"
    (is (= "Plato" (normalize "Plato"))))
  (testing "swaps first and last names"
    (is (= "Murakami, Haruki" (normalize "Haruki Murakami"))))
  (testing "trims leading and trailing whitespace"
    (is (= "Boi, Big" (normalize "   Big Boi   "))))
  (testing "initializes middle name"
    (is (= "Thoreau, Henry D." (normalize "Henry David Thoreau"))))
  (testing "does not initialize one letter middle name"
    (is (= "Truman, Harry S" (normalize "Harry S Truman"))))
  (testing "initializes each of multiple middle names"
    (is (= "Louis-Dreyfus, Julia S. E." (normalize "Julia Scarlett Elizabeth Louis-Dreyfus"))))
  (testing "appends suffixes to end"
    (is (= "King, Martin L., Jr." (normalize "Martin Luther King, Jr."))))
  (testing "throws when name contains two commas"
    (is (thrown? IllegalArgumentException (normalize "Thurston, Howell, III")))))
