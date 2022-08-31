(ns aoc2016.day1-1
  (:require [clojure.string :as str]))


(defn input []
  (slurp "resources/day1.txt"))


(defn parse-input [text]
  (->> text
       ((fn [text] (str/split text #",")))
       (map str/trim)
       (map (fn [command]
              [(subs command 0 1)
               (Integer/parseInt (subs command 1))]))))


(comment
  (parse-input (input)))


(defn change-position [{:keys [current-position current-command prev-direction]}]
  (let [curr-direction (first current-command)
        step           (second current-command)]
    (condp = [prev-direction curr-direction]
      [nil "L"] [(update current-position :x - step) "L"]
      [nil "R"] [(update current-position :x + step) "R"]
      ["L" "L"] [(update current-position :y - step) "D"]
      ["L" "R"] [(update current-position :y + step) "U"]
      ["R" "R"] [(update current-position :y - step) "D"]
      ["R" "L"] [(update current-position :y + step) "U"]
      ["U" "L"] [(update current-position :x - step) "L"]
      ["U" "R"] [(update current-position :x + step) "R"]
      ["D" "L"] [(update current-position :x + step) "R"]
      ["D" "R"] [(update current-position :x - step) "L"])))


(defn calculate-end-position [parsed-input]
  (->> parsed-input
       (reduce (fn [acc command]
                 (let [step (change-position {:current-position (:current-position acc)
                                              :current-command  command
                                              :prev-direction   (:direction acc)})]
                   {:current-position (first step)
                    :direction        (second step)}))
         {:current-position {:x 0 :y 0}
          :direction        nil})
       :current-position))


(defn calculate-distance [{:keys [x y]}]
  (+ (Math/abs x)
     (Math/abs y)))


(defn run []
  (->> (input)
       parse-input
       calculate-end-position
       calculate-distance))


(comment
  (run))
