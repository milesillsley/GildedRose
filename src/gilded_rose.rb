class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

  def reduce_sell_in
    @items.each do |item|
      unless item.name == "Sulfuras, Hand of Ragnaros" then
        item.sell_in = item.sell_in - 1
      end
    end
  end

  def reduce_quality
    @items.each do |item|
      unless (item.name == "Sulfuras, Hand of Ragnaros" ||
              item.name == "Aged Brie") then
        item.quality = item.quality - 1
        item.quality = item.quality - 1 if item.sell_in == 0
        item.quality = 0 if item.quality < 0
        item.quality = 0 if item.name.start_with?('Backstage passes') && item.sell_in == 0
      end
    end
  end

  def increase_quality
    @items.each do |item|
      if item.name == "Aged Brie"
        item.quality = item.quality + 1
        item.quality = 50 if item.quality > 50
      elsif item.name.start_with?('Backstage passes')
        item.quality = item.quality + 1 if item.sell_in > 10
        item.quality = item.quality + 2 if item.sell_in <= 10 && item.sell_in > 5
        item.quality = item.quality + 3 if item.sell_in <= 5 && item.sell_in > 0
        item.quality = 50 if item.quality > 50
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
