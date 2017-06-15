class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      reduce_quality(item)
      degrade_conjoured(item)
      age_the_brie(item)
      hike_backstage_passes(item)
      reduce_sell_in(item)
    end
  end

  private

  def reduce_sell_in(item)
    unless item.name == "Sulfuras, Hand of Ragnaros" then
      item.sell_in -= 1
      item.sell_in = 0 if item.sell_in < 0
    end
  end

  def reduce_quality(item)
    unless (item.name == "Sulfuras, Hand of Ragnaros" ||
            item.name == "Aged Brie" ||
            item.name.start_with?('Backstage passes') ||
            item.name.start_with?('Conjured')) then
      item.quality -= 1
      item.quality -= 1 if item.sell_in == 0
      item.quality = 0 if item.quality < 0
    end
  end

  def degrade_conjoured(item)
    if item.name.start_with?('Conjured')
      item.quality -= 2
      item.quality = 0 if item.quality < 0
    end
  end

  def hike_backstage_passes(item)
    if item.name.start_with?('Backstage passes')
      item.quality += 1 if item.sell_in > 10
      item.quality += 2 if item.sell_in <= 10 && item.sell_in > 5
      item.quality += 3 if item.sell_in <= 5 && item.sell_in > 0
      item.quality = 0 if item.sell_in == 0
      item.quality = 50 if item.quality > 50
    end
  end

  def age_the_brie(item)
    if item.name == "Aged Brie"
      item.quality += 1
      item.quality = 50 if item.quality > 50
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
