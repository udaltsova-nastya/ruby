# Создать модуль, который позволит указывать название компании-производителя и получать его.
# Подключить модуль к классам Вагон и Поезд
module Manufacturer

  def manufacturer
    @manufacturer
  end
# производитель указывается один раз, повторный вызов метода не меняет производителя
  def manufacturer=(manufacturer)
    #return if @manufacturer
    @manufacturer ||= manufacturer 
  end 


end
