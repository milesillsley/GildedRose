describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

  describe "#reduce_sell_in" do
    it "reduces the sell_in value of items" do
      items = [Item.new("foo", 2, 0)]
      GildedRose.new(items).reduce_sell_in()
      expect(items[0].sell_in).to eq 1
    end
    it "does not reduce the sell_in value of Sulfuras" do
      items = [Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=5, quality=80)]
      GildedRose.new(items).reduce_sell_in()
      expect(items[0].sell_in).to eq 5
    end
  end

  describe "#reduce_quality" do
    it "reduces the quality value of items" do
      items = [Item.new("foo", 1, 1)]
      GildedRose.new(items).reduce_quality()
      expect(items[0].quality).to eq 0
    end
    it "does not reduce the quality of Aged Brie or Sulfuras" do
      items = [
        Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=5, quality=80),
        Item.new(name="Aged Brie", sell_in=5, quality=5)
      ]
      GildedRose.new(items).reduce_quality()
      expect(items[0].quality).to eq 80
      expect(items[1].quality).to eq 5
    end
  end

end
