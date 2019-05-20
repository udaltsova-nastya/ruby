module Accessors
  # Модуль говорит: когда меня (self) включают (included) в какой-то класс (klass)
  # мне нужно
  # 1. подключить методы из ClassMethods в klass в качестве методов класса
  # 2. подключить методы из InstanceMethods в klass в качастве инстанс-методов
  def self.included(klass)
    klass.extend ClassMethods
    # klass.send :include, InstanceMethods
  end

  # :nodoc:
  module ClassMethods
    # Этот метод динамически создает геттеры и сеттеры 
    # для любого кол-ва атрибутов,
    # при этом сеттер сохраняет все значения инстанс-переменной при изменении этого значения.
    # Пример вызова:
    # attr_accessor_with_history :wagons, :stations, ...
    # # => создает три метода
    #
    # # reader
    # def wagons
    #   @wagons
    # end
    #
    # # writer
    # def wagons=(wagons)
    #   @wagons = wagons
    #   @wagons_history ||= []
    #   @wagons_history << wagons
    # end
    #
    # # history
    # def wagon_history
    #   @wagon_history  
    # end
    def attr_accessor_with_history(*attributes)
      # attributes - массив переданных значений
      attributes.each do |attribute|
        self.class_eval(
          <<-"INSTANCE_DEFINITIONS"
            # reader
            def #{attribute}
              @#{attribute}
            end

            # writer
            def #{attribute}=(#{attribute})
              @#{attribute} = #{attribute}
              @#{attribute}_history ||= []
              @#{attribute}_history << #{attribute}
            end

            # history
            def #{attribute}_history
              @#{attribute}_history
            end
          INSTANCE_DEFINITIONS
        )
      end
    end

    def strong_attr_accessor(attribute, klass)
      self.class_eval(
        <<-"INSTANCE_DEFINITIONS"
          # reader
          def #{attribute}
            @#{attribute}
          end

          # writer
          def #{attribute}=(#{attribute})
            raise ArgumentError, "Значение должно быть класса #{klass}" unless #{attribute}.is_a? #{klass}
            @#{attribute} = #{attribute}
          end
        INSTANCE_DEFINITIONS
      )
    end
  end

  # :nodoc:
  # module InstanceMethods
  # end
end
