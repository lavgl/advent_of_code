(ns aoc2016.day2-2
  (:require [clojure.string :as str]))


(defn parsed-input []
  (->> (slurp "resources/day2.txt")
       (str/split-lines)
       (map #(str/split % #""))))


(comment
  (parsed-input))


(def possible-moves
  {"1" {"D" "3"}
   "2" {"R" "3"
        "D" "6"}
   "3" {"U" "1"
        "L" "2"
        "R" "4"
        "D" "7"}
   "4" {"L" "3"
        "D" "8"}
   "5" {"R" "6"}
   "6" {"U" "2"
        "R" "7"
        "D" "A"
        "L" "5"}
   "7" {"U" "3"
        "R" "8"
        "D" "B"
        "L" "6"}
   "8" {"U" "4"
        "R" "9"
        "D" "C"
        "L" "7"}
   "9" {"L" "8"}
   "A" {"U" "6"
        "R" "B"}
   "B" {"U" "7"
        "R" "C"
        "D" "D"
        "L" "A"}
   "C" {"U" "8"
        "L" "B"}
   "D" {"U" "B"}})


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
