class Author < ApplicationRecord

  def coordinates
    # 緯度と経度について、それぞれ定義するメソッド
    # 第一要素が緯度で第二要素が経度
    [rand(90), rand(90)]
  end

  def publication_years
    # 出版した年度が配列でランダムに最大10個返ってくる
    (1..rand(10)).to_a.map { 1900 - rand(100)}
  end

  validates :last_name, presence: true
end
