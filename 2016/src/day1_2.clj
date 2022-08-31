(ns aoc2016.day1-2
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


(defn visited-positions [p1 p2]
  (let [x1 (:x p1)
        y1 (:y p1)
        x2 (:x p2)
        y2 (:y p2)]
    (cond
      (= x1 x2)
      (disj (->> (range (min y1 y2) (inc (max y1 y2)))
                 (map (fn [y]
                        {:x x1
                         :y y}))
                 set)
        p1)

      (= y1 y2)
      (disj (->> (range (inc (min x1 x2)) (inc (max x1 x2)))
                 (map (fn [x]
                        {:x x
                         :y y1}))
                 set)
        p1))))


(comment
  (visited-positions {:x 10 :y 10} {:x 10 :y 7}))


(defn calculate-end-position [parsed-input]
  (->> parsed-input
       (reduce (fn [acc command]
                 (let [old-position                 (:current-position acc)
                       [new-position new-direction] (change-position {:current-position old-position
                                                                      :current-command  command
                                                                      :prev-direction   (:direction acc)})
                       visited                      (:visited-positions acc)
                       curr-visited                 (visited-positions old-position new-position)
                       visited-twice                (first (clojure.set/intersection visited curr-visited))]
                   (if visited-twice
                     (reduced {:current-position visited-twice})
                     {:current-position  new-position
                      :direction         new-direction
                      :visited-positions (into (:visited-positions acc) curr-visited)})))
         {:current-position  {:x 0 :y 0}
          :direction         nil
          :visited-positions #{{:x 0 :y 0}}})
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





























