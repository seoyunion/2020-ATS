import numpy as np
import pandas as pd
from dataclasses import dataclass
import queue


def taxi_id_num(num_taxis):
    arr = np.arange(num_taxis)
    np.random.shuffle(arr)
    for i in range(num_taxis):
        yield arr[i]
ids = taxi_id_num(10)
print(next(ids))
print(next(ids))
print(next(ids))


def shift_info():
    start_times_and_freqs = [(0,8), (8, 30), (16, 15)]
    indices = np.arange(len(start_times_and_freqs))

    while True:
        idx = np.random.choice(indices, p=[0.25,0.5, 0.25])
        # print(idx)
        start = start_times_and_freqs[idx]
        # print(start)
        yield (start[0], start[0]+7.5, start[1])


print(next(shift_info()))


def taxi_process(taxi_id_generator, shift_info_generator):
    taxi_id = next(taxi_id_generator)
    shift_start, shift_end, shift_mean_trips = next(shift_info_generator)

    actural_trips = round(np.random.normal(loc=shift_mean_trips, scale=2))

    avg_trip_time = 6.5 /shift_mean_trips *60
    #convert mean trip time to minutes
    btw_events_time = 1.0 /(shift_mean_trips-1) *60

    time = shift_start
    yield TimePoint(taxi_id, 'start shift', time)
    deltaT = np.random.poisson(btw_events_time)
    time += deltaT
    for i in range(actural_trips):
        yield TimePoint(taxi_id, 'pick up', time)

        deltaT = np.random.poisson(avg_trip_time)/ 60
        time += deltaT
        yield TimePoint(taxi_id, 'drop off', time)

        deltaT = np.random.poisson(btw_events_time) /60
        time += deltaT

    deltaT = np.random.poisson(btw_events_time) /60
    time += deltaT
    yield TimePoint(taxi_id, 'end_shift', time )


@dataclass
class TimePoint:
    taxi_id: int
    name: str
    time: float

    def __lt__(self, other):
        return self.time <other.time

class Simulator:
    def _prepare_run(self):
        for t in self._taxis:
            while True:
                try:
                    e = next(t)
                    self._time_points.put(e)
                except:
                    break

    def run(self):
        sim_time = 0
        while sim_time <24:
            if self._time_points.empty():
                break
            p = self._time_points.get()
            sim_time = p.time
            print(p)

    def __init__(self, num_taxis):
        self._time_points = queue.PriorityQueue()
        taxi_id_generator = taxi_id_num(num_taxis)
        shift_info_generator = shift_info()
        self._taxis = [taxi_process(taxi_id_generator, shift_info_generator) for i in range(num_taxis)]

        self._prepare_run()


sim = Simulator(10)
sim.run()


