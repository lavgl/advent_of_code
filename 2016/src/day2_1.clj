(ns aoc2016.day2-1
  (:require [clojure.string :as str]))


(defn parsed-input []
  (->> (slurp "resources/day2.txt")
       (str/split-lines)
       (map #(str/split % #""))))


(comment
  (parsed-input))


(def possible-moves
  {"1" {"R" "2"
        "D" "4"}
   "2" {"L" "1"
        "R" "3"
        "D" "5"}
   "3" {"L" "2"
        "D" "6"}
   "4" {"U" "1"
        "R" "5"
        "D" "7"}
   "5" {"U" "2"
        "R" "6"
        "D" "8"
        "L" "4"}
   "6" {"U" "3"
        "D" "9"
        "L" "5"}
   "7" {"U" "4"
        "R" "8"}
   "8" {"U" "5"
        "R" "9"
        "L" "7"}
   "9" {"U" "6"
        "L" "8"}})


(defn move [current direction]
  (get-in possible-moves [current direction] current))


(defn calculate-number [prev-number input-line]
  (reduce (fn [current direction]
            (move current direction))
    prev-number
    input-line))


(defn calculate-code [parsed-input]
  (->> parsed-input
       (reduce (fn [{:keys [code prev]} input-line]
                 (let [num (calculate-number prev input-line)]
                   {:code (str code num)
                    :prev num}))
         {:code ""
          :prev "5"})
       :code))


(defn run []
  (calculate-code (parsed-input)))


(comment
  (run))
