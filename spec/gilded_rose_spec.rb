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
    it "reduces the quality value twice as fast for items that have past it" do
      items = [Item.new("foo", 0, 5)]
      GildedRose.new(items).reduce_quality()
      expect(items[0].quality).to eq 3
    end
    it "does not reduce the quality of Aged Brie" do
      items = [Item.new(name="Aged Brie", sell_in=5, quality=5)]
      GildedRose.new(items).reduce_quality()
      expect(items[0].quality).to eq 5
    end
    it "does not reduce the quality of Sulfuras" do
      items = [Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=5, quality=80)]
      GildedRose.new(items).reduce_quality()
      expect(items[0].quality).to eq 80
    end
    it "cannot reduce quality below worthless (0)" do
      items = [Item.new("foo", 6, 0)]
      GildedRose.new(items).reduce_quality()
      expect(items[0].quality).to eq 0
    end
    it "reduces quality to 0 of backstage passes for shows that have already happened" do
      items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=0, quality=20)]
      GildedRose.new(items).reduce_quality()
      expect(items[0].quality).to eq 0
    end
  end

  describe "#increase_quality" do
    it "increases the quality of Aged Brie" do
      items = [Item.new(name="Aged Brie", sell_in=5, quality=5)]
      GildedRose.new(items).increase_quality()
      expect(items[0].quality).to eq 6
    end
    it "does not increase quality above 50" do
      items = [Item.new(name="Aged Brie", sell_in=5, quality=50)]
      GildedRose.new(items).increase_quality()
      expect(items[0].quality).to eq 50
    end
    describe "Backstage passes" do
      context "sell_in > 10" do
        it "increases the quality of Backstage passes" do
          items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20)]
          GildedRose.new(items).increase_quality()
          expect(items[0].quality).to eq 21
        end
      end
      context "5 < sell_in <= 10" do
        it "increases the quality of Backstage passes by 2" do
          items = [
            Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=20),
            Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=6, quality=20)
          ]
          GildedRose.new(items).increase_quality()
          expect(items[0].quality).to eq 22
          expect(items[1].quality).to eq 22
        end
      end
      context "0 < sell_in <= 5" do
        it "increases the quality of Backstage passes by 3" do
          items = [
            Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=20),
            Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=1, quality=20)
          ]
          GildedRose.new(items).increase_quality()
          expect(items[0].quality).to eq 23
          expect(items[1].quality).to eq 23
        end
      end
      it "does not increase quality above 50" do
        items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=49)]
        GildedRose.new(items).increase_quality()
        expect(items[0].quality).to eq 50
      end
    end
  end

end
