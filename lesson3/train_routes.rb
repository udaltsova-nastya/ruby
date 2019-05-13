# frozen_string_literal: true

# Функционал поездов, связанный с маршрутами (назначение, передвижение и т.п.)
module TrainRoutes
  attr_reader :route_current_station

  # назначение маршрута,
  # при назначении маршрута поезд перемещается на первую станцию маршрута
  def assign_route(route)
    @route = route
    move_to_route_first_station
  end

  def route_next_station
    return nil if @route_current_station == @route.stations.last

    @route.stations[route_current_station_index + 1]
  end

  def route_prev_station
    return nil if @route_current_station == @route.stations.first

    @route.stations[route_current_station_index - 1]
  end

  # Перемещение вперед по маршруту на одну станцию
  def move_forward
    raise StandardError, "Не задан маршрут" unless @route
    raise StandardError, "Поезд уже на последней станции маршрута" unless route_next_station

    remove_self_from_station(@route_current_station)
    @route_current_station = route_next_station
    add_self_to_station(@route_current_station)
  end

  def move_backward
    raise StandardError, "Не задан маршрут" unless @route
    raise StandardError, "Поезд уже на первой станции маршрута" unless route_prev_station

    remove_self_from_station(@route_current_station)
    @route_current_station = route_prev_station
    add_self_to_station(@route_current_station)
  end

  private

  def route_current_station_index
    @route.stations.index(@route_current_station)
  end

  def move_to_route_first_station
    @route_current_station = @route.stations.first
    add_self_to_station(@route_current_station)
  end
end
