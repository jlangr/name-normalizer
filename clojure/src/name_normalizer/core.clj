(ns name-normalizer.core
  (:require [clojure.string :as s]))

(defn- initial [name]
  (str " " (first name) (if (= 1 (count name)) "" ".")))

(defn- middle-initials [parts]
  (->>  parts
        (rest)
        (butlast)
        (map initial)
        (s/join)))

(defn- split-name-and-suffix [name]
  (let [parts (s/split name #",")]
    {:name (first parts)
     :suffix (if (empty? (second parts)) "" (str "," (second parts)))}))

(defn- split-base-name [parsed]
  (let [parts (s/split (:name parsed) #" ")]
    (merge parsed 
      {:first (first parts)
      :last (if (= 1 (count parts)) nil (last parts))
      :middle-initials (middle-initials parts)})))

(defn- parse [name]
  (-> name
      (split-name-and-suffix)
      (split-base-name)))

(defn- throw-if-too-many-commas [name]
  (if (> (count (filter #(= \, %) name)) 1)
    (throw (IllegalArgumentException.))))

(defn- mononym? [parsed]
  (not (:last parsed)))

(defn normalize [name]
  (throw-if-too-many-commas name)
  (let [parsed (parse (s/trim name))]
    (if (mononym? parsed)
      name
      (str (:last parsed) ", " (:first parsed) (:middle-initials parsed) (:suffix parsed)))))

